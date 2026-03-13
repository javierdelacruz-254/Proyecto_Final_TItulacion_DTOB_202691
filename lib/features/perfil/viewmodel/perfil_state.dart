class PerfilState {
  final bool isLoading;
  final bool isSaved;
  final String? error;
  final String? successMessage;

  const PerfilState({
    this.isLoading = false,
    this.isSaved = false,
    this.error,
    this.successMessage,
  });

  PerfilState copyWith({
    bool? isLoading,
    bool? isSaved,
    String? error,
    String? successMessage,
  }) {
    return PerfilState(
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      error: error,
      successMessage: successMessage,
    );
  }
}