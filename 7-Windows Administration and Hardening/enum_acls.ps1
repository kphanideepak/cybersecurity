# Get child objects and store them in a variable
$directory = Get-ChildItem

# loop through all the child objects to get the acl for each of them
foreach ($item in $directory) {
    Get-Acl $item
}
