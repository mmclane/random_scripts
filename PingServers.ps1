$erroractionpreference = "SilentlyContinue"
$a = New-Object -comobject Excel.Application
$a.visible = $True 

$b = $a.Workbooks.Add()
$c = $b.Worksheets.Item(1)

$c.Cells.Item(1,1) = "Machine Name"
$c.Cells.Item(1,2) = "Ping Status"

$d = $c.UsedRange
$d.Interior.ColorIndex = 19
$d.Font.ColorIndex = 11
$d.Font.Bold = $True
$d.EntireColumn.AutoFit($True)

$intRow = 2

$colComputers = get-content C:\Users\mclanem\Desktop\ChangePasswords\Servers.txt
foreach ($strComputer in $colComputers)
{
$c.Cells.Item($intRow, 1) = $strComputer.ToUpper()

# This is the key part

$ping = new-object System.Net.NetworkInformation.Ping
$Reply = $ping.send($strComputer)
if ($Reply.status –eq “Success”) 
{
$c.Cells.Item($intRow, 2) = “Online”
$c.Cells.Item($intRow, 2).Interior.ColorIndex = 4
}
else 
{
$c.Cells.Item($intRow, 2) = "Offline"
$c.Cells.Item($intRow, 2).Interior.ColorIndex = 3
}
$Reply = ""


$intRow = $intRow + 1

}
$d.EntireColumn.AutoFit()
