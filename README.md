# BACKUP

A menu-driven backup using Robocopy for Windows

Q: Do I need to create the destination folder prior to running the backup?<br>
A: Only if you do not include the destination folder in the destination path. For example:

Source: `C:\Users\Data`<br>
Dest: `D:`<br>
Result: `D:` will contain the contents of the Data folder; it will not create the Data folder.

Source: `C:\Users\Data`<br>
Dest: `D:\Data`<br>
Result: `D:` will contain the Data folder. If the Data folder does not already exist, you will be prompted to create it.
