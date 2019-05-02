#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.12
# Created on:   11/15/2012 8:45 AM
# Created by:   mclanem
# Organization: University Of Michigan
# Filename:     
#========================================================================

$serial = Get-WmiObject -Class Win32_BIOS 
$adname = "M-$serial"
$state = "USM"
$taskid = ""
$task = ""

$query = "http://webapps.ccs.itd.umich.edu/mibuilds/windowsreload_post.php?"
$query += "active_directory_domain_name=$adname"
$query += "`&state=$state"
$query += "`&task_sequence_id=$taskid"
$query += "`&active_task=$task"

Invoke-WebRequest $query