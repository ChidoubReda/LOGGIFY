#!/bin/bash

# Loading necessary files
source config.sh
source style.sh

configure_collection_parameters() {
    clear
    echo -e ${BOLD}${GREEN}"Configure collection parameters:\n"${NC}

    # Loop until a valid collection interval is entered
    while true; do
        read -rp "Enter the collection interval (in seconds): " INTERVAL
        # Check if INTERVAL is a positive integer
        if [[ "$INTERVAL" =~ ^[1-9][0-9]*$ ]]; then
            break # Exit the loop if INTERVAL is valid
        else
            clear
            echo -e ${RED}"Error: Please enter a valid positive integer for the collection interval.\n"${NC}
        fi
    done

    # Loop until a valid date to finish reporting is entered
    while true; do
        read -rp "Enter the date to finish reporting (YYYY-MM-DD HH:MM:SS format): " REPORT_FINISH_DATE
        # Validate the date format
        if [[ "$REPORT_FINISH_DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
            # Check if the date is in the future
            if [[ "$(date -d "$REPORT_FINISH_DATE" +%s)" -gt "$(date +%s)" ]]; then
                break # Exit the loop if REPORT_FINISH_DATE is valid
            else
                echo -e ${RED}"Error: Please enter a date in the future."${NC}
            fi
        else
            echo -e ${RED}"Error: Please enter a valid date in the format YYYY-MM-DD HH:MM:SS."${NC}
        fi
    done

    # Loop until a valid email address is entered
    while true; do
        read -rp "Enter your email address: " EMAIL
        # Check if EMAIL is a valid email address format
        if [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            break # Exit the loop if EMAIL is valid
        else
            clear
            echo -e ${RED}"Error: Please enter a valid email address.\n"${NC}
        fi
    done

    echo -e ${CYAN}"\nCollection parameters configured successfully."${NC}
    read -n 1 -rp "Press any key to continue..."
    show_menu
}
