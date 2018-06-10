#!/usr/bin/env bash

import util/namedParameters util/class util/type

class:Storage() {
    function Storage.createIfNotExist(){
        if [ ! -f ${PWD}/data.base ]; then
            touch ${PWD}/data.base;
            sqlite3 ${PWD}/data.base 'create table tracks(key varchar unique, uri varchar);'
        fi
    }

    function Storage.addTrack() {
        [string] key
        [string] uri

        sqlite3 ${PWD}/data.base "insert into tracks values('$key', '$uri');"
    }

    function Storage.isAlreadyAdded() {
        [string] key

        local result=$(sqlite3 ${PWD}/data.base "select count(*) from tracks where key='$key';")

        if [ ${result} == 0 ]; then
            @return:value 0
        else
            @return:value 1
        fi
    }

    function Storage.getTrack() {
        [string] key

        sqlite3 ${PWD}/data.base "select uri from tracks where key='$key';"
    }

}

Type::Initialize Storage