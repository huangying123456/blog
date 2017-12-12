#!/bin/bash

#git pull hy master
git add .
git commit -m 'add'
git push hy master
hexo clean && hexo g && hexo d
