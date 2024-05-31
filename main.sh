#!/bin/bash

# Loading necessary files
source selective_report.sh
source full_report.sh
source configuring.sh
source config.sh
source perf_gen.sh
source metrics.sh
# source style.sh

# Copy user configs to config.sh
# Path to the user-modifiable text file
CONFIG_TEXT_FILE="config.txt"

# Path to the configuration script
CONFIG_SCRIPT="config.sh"

# Copy the contents of config.txt into config.sh
cp "$CONFIG_TEXT_FILE" "$CONFIG_SCRIPT"

display_performance_reporting_menu() {
    clear
    echo -e ${BOLD}${GREEN}"Choose a report type:\n"${NC}
    echo "1. Full Report (All metrics)"
    echo "2. Custom Report"
    echo "3. Back to main menu"
    echo -e ${BLUE}
    read -rp "Your choice: " choice
    echo -e ${NC}
    case $choice in
    1)
        clear
        echo -e "Report will be generated in /reports directory.\n"
        clear
        echo -e ${YELLOW}"To terminate the process hit CTRL+C."${NC}
        log_file="./reports/loggify_$(date +"%Y-%m-%d").txt"
        touch "$log_file"
        print_metrics_table_header
        print_metrics_table_header >"$log_file"
        while [[ "$(date +"%Y-%m-%d %H:%M:%S")" < "$REPORT_FINISH_DATE" ]]; do
            print_metrics_table
            print_metrics_table >>"$log_file"
            sleep $INTERVAL
        done
        ;;
    2)
        configure_report_parameters
        log_file="./reports/loggify_custom_$(date +"%Y-%m-%d").txt"
        touch "$log_file"
        clear
        while [[ "$(date +"%Y-%m-%d %H:%M:%S")" < "$REPORT_FINISH_DATE" ]]; do
            print_custom_metrics_table
            print_custom_metrics_table >>"$log_file"
            sleep $INTERVAL
        done

        ;;

    *)
        echo "Invalid choice. Please enter a number between 1 and 3."
        ;;
    esac
}

show_menu() {
    choice=0
    clear
    figlet -f slant -c "LOGIFY" | lolcat
    figlet -f digital -c "Welcome to Loggify System Performance Logger."

    echo -e ${CYAN}${BOLD}${BLINK}"Please start by configuring THEN choose Performance Report\n"${NC}
    echo "1 - Program configuration"
    echo "2 - Performance Report"
    echo "3 - Previous reports"
    echo -e ${YELLOW}"4 - Exit" ${NC}
    echo -e ${BLUE}
    read -rp "Your choice: " choice
    echo -e ${NC}
    case $choice in
    1) configure_collection_parameters ;;
    2) display_performance_reporting_menu ;;
    3)
        tree reports
        read -n 1 -rp "Press any key to continue..."
        ;;
    4)
        clear
        figlet -f slant -c "Bye." | lolcat
        echo -e "\nAuthors: Nassim ZAHRI, Reda CHIDOUB\n\n\n"$ | lolcat
        exit
        ;;
    *) echo -e ${RED}"Invalid choice. Choose a number between 1 and 4."${NC} ;;
    esac
}

while true; do
    show_menu
done
