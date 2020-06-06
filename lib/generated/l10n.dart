// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get todo {
    return Intl.message(
      'Todos',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  String get emptyTodoMsg {
    return Intl.message(
      'No todo is added.',
      name: 'emptyTodoMsg',
      desc: '',
      args: [],
    );
  }

  String get clearAllLabel {
    return Intl.message(
      'Clear all',
      name: 'clearAllLabel',
      desc: '',
      args: [],
    );
  }

  String get areyouSureMsg {
    return Intl.message(
      'Are you sure?',
      name: 'areyouSureMsg',
      desc: '',
      args: [],
    );
  }

  String get removeAllMsg {
    return Intl.message(
      'All the todos will be deleted permanently',
      name: 'removeAllMsg',
      desc: '',
      args: [],
    );
  }

  String get yesLabel {
    return Intl.message(
      'Yes',
      name: 'yesLabel',
      desc: '',
      args: [],
    );
  }

  String get noLabel {
    return Intl.message(
      'No',
      name: 'noLabel',
      desc: '',
      args: [],
    );
  }

  String get addTodoLabel {
    return Intl.message(
      'Create Todo',
      name: 'addTodoLabel',
      desc: '',
      args: [],
    );
  }

  String get todoTitleLabel {
    return Intl.message(
      'Todo Title',
      name: 'todoTitleLabel',
      desc: '',
      args: [],
    );
  }

  String get todoDescLabel {
    return Intl.message(
      'Todo Description',
      name: 'todoDescLabel',
      desc: '',
      args: [],
    );
  }

  String get statusLabel {
    return Intl.message(
      'Status',
      name: 'statusLabel',
      desc: '',
      args: [],
    );
  }

  String get savelabel {
    return Intl.message(
      'Save',
      name: 'savelabel',
      desc: '',
      args: [],
    );
  }

  String get editTodoLabel {
    return Intl.message(
      'Edit Todo',
      name: 'editTodoLabel',
      desc: '',
      args: [],
    );
  }

  String get titleRequiredMsg {
    return Intl.message(
      'Title is required',
      name: 'titleRequiredMsg',
      desc: '',
      args: [],
    );
  }

  String get descRequiredMsg {
    return Intl.message(
      'Description is required',
      name: 'descRequiredMsg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ne'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}