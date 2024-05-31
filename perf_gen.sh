#!/bin/bash

# Load configuration
source config.sh

# DEFAULTS
ram_above_95="false"
disk_above_95="false"

# Function to generate CPU usage
generate_cpu_usage() {
    # Get the CPU usage percentage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "$cpu_usage%"
}

# Function to generate RAM usage
generate_ram_usage() {
    # Get the RAM usage percentage
    ram_usage=$(free -h --giga | awk '/Mem/{printf("%.2f%% (%s GB/%s GB, Free: %s GB)", ($3/$2)*100, $3, $2, $4)}')
    ram_usage_percentage=$(free | awk '/Mem/{printf("%.2f", ($3/$2)*100)}')
    # Check if RAM usage is above 95%
    # echo "$ram_usage_percentage > 95" | bc -l
    if [ "$(echo "$ram_usage_percentage > 95" | bc -l)" -eq 1 ]; then
        ram_above_95="true"
    else
        ram_above_95="false"
    fi

    echo "$ram_usage"
}

# Function to generate disk usage
generate_disk_usage() {
    # Get the disk usage percentage for the root directory "/"
    disk_usage=$(df -h / | awk 'NR==2{printf("%.2f%% (%.2f GB/%.2f GB, Free: %.2f GB)", $5, $3, $2, $4)}')
    disk_usage_percentage=$(df / | awk 'NR==2{printf("%.2f", $5)}')
    # Check if disk usage is above 95%
    # echo "$disk_usage_percentage > 10" | bc -l
    if [ "$(echo "$disk_usage_percentage > 95" | bc -l)" -eq 1 ]; then
        disk_above_95="true"
    else
        disk_above_95="false"
    fi

    echo "$disk_usage"
}

# Function to generate network usage in Kbps
generate_network_usage() {
    # Get the network usage in Kbps using netstat
    network_usageRX=$(netstat -e -n -i | grep 'RX packets' | head -1 | awk '{print "  ▼ " $6$7}')
    network_usageTX=$(netstat -e -n -i | grep 'TX packets' | head -1 | awk '{print "  ▲ " $6$7}')
    echo "$network_usageRX  $network_usageTX"
}

# Example usage
# date "+%D %T"
# generate_cpu_usage
# generate_ram_usage
# generate_disk_usage
# generate_network_usage

# echo $ram_above_95
# echo $disk_above_95
