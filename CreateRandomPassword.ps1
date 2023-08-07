# Define an array of common words
$words = @("apple", "banana", "cherry", "dog", "elephant", "frog", "grape", "honey", "icecream", "jelly")

# Generate a random index for selecting words
$wordIndex1 = Get-Random -Minimum 0 -Maximum $words.Length
$wordIndex2 = Get-Random -Minimum 0 -Maximum $words.Length

# Generate a random number between 10 and 99
$randomNumber = Get-Random -Minimum 10 -Maximum 100

# Combine words and number to create the password
$password = $words[$wordIndex1] + $words[$wordIndex2] + $randomNumber

# Output the generated password
Write-Host "Generated Password: $password"
