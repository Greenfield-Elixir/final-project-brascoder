#!/bin/sh
find . -name "*.proto" | xargs -I {} protoc --elixir_out=lib/ {}
