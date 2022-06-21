#!/bin/bash 
touch graphics_query_output
lspci -nnk | grep -i vga -A3 > graphics_query_output
