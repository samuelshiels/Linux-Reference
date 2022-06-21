#!/bin/bash
touch memory_info_output
sudo dmidecode --type 17 > memory_info_output
sudo lshw -short -C memory > memory_info_output
