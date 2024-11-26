
# Get-XKCDPassword

**Get-XKCDPassword** is a PowerShell module for generating memorable passwords in the style of the famous [XKCD comic](https://xkcd.com/936/). The passwords consist of random words, customizable delimiters, and a two-digit number at the end. This module dynamically loads an external word list for flexibility and modularity.

---

## Features

- **Memorable Passwords**: Generates passwords using random words.
- **Customizable Options**:
  - Set the minimum number of words.
  - Define the minimum password length.
  - Specify a custom delimiter (e.g., `_`, `-`, `.`, etc.).
- **Color-Coded Output**:
  - Numbers are displayed in red.
  - Special characters (delimiters) are displayed in blue.
  - Letters remain in the default console color.
- **Dynamic Word List**: Uses an external dictionary (`words.txt`) stored in the module folder.
- **Cross-Platform**: Works on Windows, macOS, and Linux with modern PowerShell.

---

## Installation

Copy and Paste the following command to install this package using PowerShellGet
```powershell
Install-Module -Name get-xkcdpassword
```

---

## Usage

### Generate a Single Password with Default Settings
```powershell
Get-XKCDPassword
```
**Example Output** (colors visible in supported consoles):
```
Correct-Horse-42
```

### Generate Multiple Passwords with Custom Options
```powershell
Get-XKCDPassword -MinimalWordsCount 4 -MinimalCharactersCount 15 -Delimiter "_" -List 3
```
**Example Output**:
```
Apple_Banana_Cloud_19
Orange_Melon_Storm_84
Peach_River_Sunshine_55
```

### Parameters

| Parameter               | Description                                                                 | Default Value |
|-------------------------|-----------------------------------------------------------------------------|---------------|
| `-MinimalWordsCount`    | Minimum number of words in the password.                                   | `2`           |
| `-MinimalCharactersCount` | Minimum total length of the password (including delimiters and numbers). | `10`          |
| `-Delimiter`            | Character(s) used to separate words.                                       | `"-"`         |
| `-List`                 | Number of passwords to generate.                                           | `1`           |

---

## File Structure

The module folder contains the following files:

```
get-xkcdpassword/
│-- get-xkcdpassword.psd1      # Module manifest with metadata.
│-- get-xkcdpassword.psm1      # Main script containing the Get-XKCDPassword function.
│-- words.txt                  # External dictionary used for password generation.
```

---

## Requirements

- **PowerShell Version**: Requires PowerShell 5.1 or later.
- **Console Support**: Color-coded output works in modern consoles like Windows Terminal, macOS Terminal, and Linux shells. 

---

## Credits

### Word List
The word list (`words.txt`) is sourced from [Michael Wehar's Public Domain Word Lists](https://github.com/MichaelWehar/Public-Domain-Word-Lists). This list is in the public domain and can be freely reused or modified.

### Inspiration
Inspired by [XKCD's "Password Strength" comic](https://xkcd.com/936/).

---
