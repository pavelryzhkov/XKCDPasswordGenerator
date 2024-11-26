function Get-XKCDPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$MinimalWordsCount = 2,

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$MinimalCharactersCount = 10,

        [Parameter(Mandatory = $false)]
        [string]$Delimiter = "-",

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$List = 1
    )

    # Define the path to the words.txt file using $PSScriptRoot
    $WordListPath = Join-Path -Path $PSScriptRoot -ChildPath "words.txt"

    # Load external word list
    if (-Not (Test-Path $WordListPath)) {
        throw "Error: The word list file 'words.txt' is missing from the module folder."
    }
    $WordList = Get-Content $WordListPath

    # Validate that the word list is not empty
    if ($WordList.Count -eq 0) {
        throw "Error: The word list file 'words.txt' is empty."
    }


    # Validate input parameters
    if ($MinimalWordsCount -lt 1) {
        throw [System.ArgumentException]::new("Error: MinimalWordsCount cannot be less than 1.")
    }
    if ($MinimalCharactersCount -lt 1) {
        throw [System.ArgumentException]::new("Error: MinimalCharactersCount cannot be less than 1.")
    }
    if ($List -lt 1) {
        throw [System.ArgumentException]::new("Error: List cannot be less than 1.")
    }

    # Function to generate a single password
    function GeneratePassword {
        do {
            # Select random words
            $SelectedWords = @()
            for ($i = 1; $i -le $MinimalWordsCount; $i++) {
                $Word = $WordList | Get-Random
                $SelectedWords += ($Word.Substring(0, 1).ToUpper() + $Word.Substring(1))
            }

            # Form the base of the password
            $PasswordBase = ($SelectedWords -join $Delimiter)
            $PasswordLength = $PasswordBase.Length

        } while ($PasswordLength -lt ($MinimalCharactersCount - 3)) # Account for delimiter and number length

        # Add a two-digit number at the end (from 1 to 99)
        $RandomNumber = Get-Random -Minimum 1 -Maximum 100
        return "$PasswordBase$Delimiter$RandomNumber"
    }

   # Function to apply color formatting to the password
   function FormatPassword {
    param (
        [string]$Password
    )
    
    # ANSI escape sequence for colors
    $esc = [char]27

    # Define colors for each type of character
    $numberColor = "$esc[38;2;255;0;0m"  # Red for numbers
    $specialColor = "$esc[38;2;0;0;255m" # Blue for special characters
    $resetColor = "$esc[0m"              # Reset to default

    # Process each character in the password and apply appropriate color
    $formattedPassword = ""
    foreach ($char in $Password.ToCharArray()) {
        if ($char -match '\d') {
            # Numbers in red
            $formattedPassword += "$numberColor$char$resetColor"
        } elseif ($char -match '[^a-zA-Z0-9]') {
            # Special characters in blue
            $formattedPassword += "$specialColor$char$resetColor"
        } else {
            # Letters remain unformatted (default console color)
            $formattedPassword += "$char"
        }
    }

    return $formattedPassword
}

# Generate and output passwords with formatting
try {
    for ($i = 1; $i -le $List; $i++) {
        $password = GeneratePassword
        Write-Host (FormatPassword -Password $password) -NoNewline
        Write-Host ""
    }
} catch {
    Write-Error $_.Exception.Message
}
}