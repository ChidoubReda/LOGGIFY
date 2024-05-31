#!/bin/bash

# Loading necessary files
# source config.sh
source style.sh

# The following variables will define which metric(s) to be generated
CPU_METRIC="false"
MEMORY_METRIC="false"
DISK_METRIC="false"
NETWORK_METRIC="false"
METRICS=0

# Implements the user's choice
config_metrics_choice() {
    if grep -q "\<1\>" <<<"$METRICS"; then
        CPU_METRIC="true"
    fi
    if grep -q "\<2\>" <<<"$METRICS"; then
        MEMORY_METRIC="true"
    fi
    if grep -q "\<3\>" <<<"$METRICS"; then
        DISK_METRIC="true"
    fi
    if grep -q "\<4\>" <<<"$METRICS"; then
        NETWORK_METRIC="true"
    fi
}

# Define the function to configure report generation parameters
configure_report_parameters() {
    clear
    echo -e ${GREEN}"Configuring report generation parameters:\n"${NC}
    echo -e ${BOLD}"Which metrics do you want to monitor?"${NC}
    echo "1. CPU Usage"
    echo "2. Memory Usage"
    echo "3. Disk Usage"
    echo "4. Back to the main menu"
    echo -e ${CYAN}
    read -rp "Enter the numbers of the metrics separated by spaces: " METRICS
    echo -e ${NC}
    config_metrics_choice
    clear
    echo "Report generation parameters configured successfully."
    echo -e ${BOLD}${GREEN}"Choosed metrics: "${NC}
    if [ "$CPU_METRIC" == "true" ]; then
        echo "* CPU"
    fi
    if [ "$MEMORY_METRIC" == "true" ]; then
        echo "* RAM"
    fi
    if [ "$DISK_METRIC" == "true" ]; then
        echo "* DISK"
    fi
    if [ "$NETWORK_METRIC" == "true" ]; then
        echo "* NETWORK"
    fi
    if [ "$CPU_METRIC" == "false" ] && [ "$MEMORY_METRIC" == "false" ] && [ "$DISK_METRIC" == "false" ] && [ "$NETWORK_METRIC" == "false" ]; then
        echo "No metrics chosen."
    fi
    read -n 1 -rp "Press any key to continue..."
}
