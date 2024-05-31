#! /bin/bash

# Loading necessary files
source config.sh
source perf_gen.sh
source metrics.sh
source style.sh

# Function to print performance metrics table header
print_metrics_table_header() {
    printf "\n—————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————\n"
    printf "%-20s | %-10s | %-40s | %-40s | %-30s" "Date/Time" "CPU" "RAM" "Disk" "Network"
    # printf "\tTime\t\t| CPU Usage |\t\t\tRAM Usage\t\t\t|\t\t\tDisk Usage\t\t\t|\tNetwork Usage"
    printf "\n—————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————\n"
}

# Function to print performance metrics table
print_metrics_table() {
    cpu=$(generate_cpu_usage)
    ram=$(generate_ram_usage)
    disk=$(generate_disk_usage)
    network=$(generate_network_usage)
    printf "%-20s | %-10s | %-40s | %-40s | %-30s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$cpu" "$ram" "$disk" "$network"

    if $ram_above_95; then
        printf "Warning: Running low on memory.\n"
    fi
    if $disk_above_95; then
        printf "Warning: Running low on storage space.\n"
    fi
    printf "\n"
}

# print_metrics_table_header
# print_metrics_table
# print_metrics_table
# print_metrics_table
# print_metrics_table
