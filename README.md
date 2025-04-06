In this repository you will find various shell scripts I have created to automate redudants tasks.

# Shell Scripts

[Decompression Chain Script](decompression_chain.sh)
  * This was created for a CTF Challenge where I was given a file will multiple layers and various types of compression. I wrote this script to automate the process. It checks the file to see the compression used and then decropmresses the file based on the output. It continues to do this until the output format is plain text. 

[Simple Brute Force Script](otw_l24_ncbrute.sh)
  * This was created for a CTF challenge where I needed to connect via NetCat using a known password followed by an space and an unkown 4-digit pin. This script automates the process trying each possible comibination until it is successful.
  * Note: I ended up figuring out a better method, as this method takes a long time to execute. But I kept it as a good example of a basic brute-force script. 
