# BACKUP

A menu-driven backup using Robocopy for Windows

Q: Do I need to create the destination folder prior to running the backup?<br>
A: Only if you do not include the destination folder in the destination path. For example:

#Source		Dest      Result
`C:\Users\Data`	`D:`	  `D:` will contain the contents of the Data folder; it will not create the Data folder.<br>
`C:\Users\Data`	`D:\Data` `D:` will contain the Data folder. If the Data folder does not already exist, you will be prompted to create it.
