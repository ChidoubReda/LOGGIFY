#! /bin/bash

# Loading necessary files
source metrics.sh
source perf_gen.sh
source config.sh

# Execute the function that prompts the user which metrics to generate
# configure_report_parameters

print_custom_metrics_table() {
    echo -e "\n" $(date +"%Y-%m-%d %H:%M:%S")
    if [ "$CPU_METRIC" == "true" ]; then
        echo -e "CPU usage:\t" $(generate_cpu_usage)
    fi
    if [ "$MEMORY_METRIC" == "true" ]; then
        echo -e "RAM usage:\t" $(generate_ram_usage)
    fi
    if [ "$DISK_METRIC" == "true" ]; then
        echo -e "DISK usage:\t" $(generate_disk_usage)
    fi
    if [ "$NETWORK_METRIC" == "true" ]; then
        echo -e "NETWORK usage:\t" $(generate_network_usage)
    fi
    if [ "$CPU_METRIC" == "false" ] && [ "$MEMORY_METRIC" == "false" ] && [ "$DISK_METRIC" == "false" ] && [ "$NETWORK_METRIC" == "false" ]; then
        echo "No metrics chosen."
    fi
}

# print_custom_metrics_table
# print_custom_metrics_table
# print_custom_metrics_table
