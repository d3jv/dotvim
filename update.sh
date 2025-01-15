#!/bin/bash

git pull --recurse-submodules && git submodule init && git submodule update --remote --merge --recursive --depth 1
