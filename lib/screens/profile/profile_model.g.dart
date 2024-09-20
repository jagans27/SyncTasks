// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileModel on _ProfileModelBase, Store {
  late final _$isBiometricEnabledAtom =
      Atom(name: '_ProfileModelBase.isBiometricEnabled', context: context);

  @override
  bool get isBiometricEnabled {
    _$isBiometricEnabledAtom.reportRead();
    return super.isBiometricEnabled;
  }

  @override
  set isBiometricEnabled(bool value) {
    _$isBiometricEnabledAtom.reportWrite(value, super.isBiometricEnabled, () {
      super.isBiometricEnabled = value;
    });
  }

  late final _$_ProfileModelBaseActionController =
      ActionController(name: '_ProfileModelBase', context: context);

  @override
  void setIsBiometricEnabled({required bool isBiometricEnabled}) {
    final _$actionInfo = _$_ProfileModelBaseActionController.startAction(
        name: '_ProfileModelBase.setIsBiometricEnabled');
    try {
      return super
          .setIsBiometricEnabled(isBiometricEnabled: isBiometricEnabled);
    } finally {
      _$_ProfileModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isBiometricEnabled: ${isBiometricEnabled}
    ''';
  }
}
