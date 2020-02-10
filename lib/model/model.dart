import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';


const tableTodo = SqfEntityTable(
    tableName: 'todos',
    primaryKeyName: 'id',
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,


    fields: [
      SqfEntityField('text', DbType.text),
      SqfEntityField('completed', DbType.bool, defaultValue: false)
    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);


@SqfEntityBuilder(appDb)
const appDb = SqfEntityModel(
    modelName: 'appDb', // optional
    databaseName: 'todo.db',
    databaseTables: [tableTodo],
    sequences: [seqIdentity],
    bundledDatabasePath: null
);