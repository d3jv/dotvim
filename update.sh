#!/bin/bash

git pull --recurse-submodules && git submodule init && git submodule update --recursive --depth 1
