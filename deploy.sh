#!/bin/bash

git pull hy master
hexo clean && hexo g && hexo d
