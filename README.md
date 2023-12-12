# Webpage Downloader Script

This script is a simple webpage downloader that uses `curl` to download webpages. It prompts you for a URL and a directory to save the downloaded webpage as an HTML file.

I created this script to help my workflow when keeping track of job's I've applied to. 
In the past I've had recruiters/hiring managers reach out to me about a role I applied to only to find that the original job posting to be taken down leaving me in the dark about the role itself.
To combat this I began saving the job postings as webarchives when applying.
Getting the pathname for the saved archive was cumbersome so I created this script to streamline the process.

## Prerequisites

- [Zsh](https://www.zsh.org/) shell
- [curl](https://curl.se/)

## Usage

1. Make the Script Executable:
   - `chmod +x webpageDownloader.zsh`
2. Run the Script:
   - `./webpageDownloader.zsh`
3. Follow the Prompts:
   - You'll be prompted to enter the URL of the webpage you want to save.
   - If the script doesn't find a configuration file (config.txt), it will prompt you to enter the directory where you want to save the files.
4. View the Result:
   - The webpage will be downloaded and saved as an HTML file in the specified directory.
   - The script will display a message indicating where the webpage has been saved.
   - The script will ask if you would like to download another website
     - `y` repeat from step 3
     - `n' script exits

## Configuration
- The script uses a configuration file (config.txt) to store the default save directory. If the file doesn't exist, the script will prompt you to enter the directory.
- Modify the script or configuration file to customize the behavior according to your preferences.

## License

This script is released under the [MIT License](MITLicense.txt).

