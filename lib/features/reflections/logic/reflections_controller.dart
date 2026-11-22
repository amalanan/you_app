import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/errors/failures.dart';
import '../../../core/helpers/data_events.dart';
import '../data/reflection_repository.dart';
import '../models/reflection_entry.dart';

/// The list behind "My Reflections": loads the newest reflections 20 at a time
/// and reloads quietly when something is saved (DataEvents).
/// Create it when the section opens, call [load] once, and [dispose] it when it closes.
class ReflectionsController extends ChangeNotifier {
  ReflectionsController() {
    DataEvents.instance.addListener(_onDataChanged);
  }

  static const pageSize = 20;

  final List<ReflectionEntry> _entries = [];
  final Set<String> _keys = {};
  int _nextOffset = 0;
  int _generation =
      0; // bumped on every first-page load, so late answers are dropped

  bool _started = false;
  bool _loaded = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = false;
  bool _loadMoreFailed = false;
  bool _fetchingFirst = false;
  bool _reloadQueued = false;
  bool _disposed = false;
  Failure? _failure;

  List<ReflectionEntry> get entries => UnmodifiableListView(_entries);

  /// First load (with a spinner) is running.
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  /// The last "load more" failed; call [retryLoadMore].
  bool get loadMoreFailed => _loadMoreFailed;

  /// Why the first load failed (use it to tell "offline" from "error").
  Failure? get failure => _failure;
  String? get error => _failure?.message;

  /// Loaded successfully and there is nothing to show yet.
  bool get isEmpty => _loaded && _entries.isEmpty && _failure == null;

  /// First page, with a spinner. Also the "Retry" after an error.
  Future<void> load() => _loadFirstPage(silent: false);

  /// Reloads from the top without clearing the list or showing a spinner.
  Future<void> refresh() => _loadFirstPage(silent: true);

  Future<void> _loadFirstPage({required bool silent}) async {
    _started = true;
    if (_fetchingFirst) {
      _reloadQueued = true; // run once more when the current request ends
      return;
    }
    _fetchingFirst = true;
    _generation++;
    _isLoadingMore = false;
    _loadMoreFailed = false;
    if (!silent) {
      _isLoading = true;
      _failure = null;
      _notify();
    }

    // A reload keeps as many rows as are already on screen.
    final limit = math.max(pageSize, _entries.length);
    try {
      final page = await ReflectionRepository.instance.getEntries(
        limit: limit,
        offset: 0,
      );
      if (_disposed) return;
      _entries.clear();
      _keys.clear();
      _addNew(page);
      _nextOffset = page.length;
      _hasMore = page.length >= limit;
      _failure = null;
      _loaded = true;
    } catch (e) {
      if (_disposed) return;
      // A quiet reload that fails keeps the list already on screen.
      if (!silent || _entries.isEmpty) _failure = ErrorHandler.handle(e);
    } finally {
      _fetchingFirst = false;
    }

    _isLoading = false;
    _notify();
    if (_reloadQueued) {
      _reloadQueued = false;
      await _loadFirstPage(silent: true);
    }
  }

  /// Next page. Does nothing while another request runs or when there is no more.
  Future<void> loadMore() async {
    if (!_loaded ||
        _fetchingFirst ||
        _isLoadingMore ||
        !_hasMore ||
        _loadMoreFailed) {
      return;
    }
    final generation = _generation;
    _isLoadingMore = true;
    _notify();
    try {
      final page = await ReflectionRepository.instance.getEntries(
        limit: pageSize,
        offset: _nextOffset,
      );
      if (_disposed || generation != _generation) return;
      _addNew(page);
      _nextOffset += page.length;
      _hasMore = page.length >= pageSize;
    } catch (_) {
      if (_disposed || generation != _generation) return;
      _loadMoreFailed = true;
    }
    _isLoadingMore = false;
    _notify();
  }

  Future<void> retryLoadMore() {
    _loadMoreFailed = false;
    return loadMore();
  }

  /// Adds only entries not already in the list (kind + id is the key).
  void _addNew(List<ReflectionEntry> page) {
    for (final e in page) {
      if (_keys.add('${e.kind.name}:${e.id}')) _entries.add(e);
    }
  }

  // Something was saved: reload quietly (only after the first load was requested).
  void _onDataChanged() {
    if (_started) refresh();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    DataEvents.instance.removeListener(_onDataChanged);
    super.dispose();
  }
}
