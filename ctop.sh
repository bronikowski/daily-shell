#!/bin/sh
ps ax --sort -pcpu,-%mem -o pcpu,comm,%mem | grep -v 0.0 | grep -v ps
