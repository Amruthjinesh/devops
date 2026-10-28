# Day 17 — PowerShell Automation: GitHub to Obsidian



**Date:** 28 October 2026



## 🎯 Objective



Automate the process of pushing my DevOps notes to GitHub and copying missing notes into my Obsidian vault using PowerShell.



## 1. Existing Setup



* **Local repository:** `C:\\Users\\Amruth\\linux-system-monitor`

* **Notes folder:** `C:\\Users\\Amruth\\linux-system-monitor\\notes`

* **GitHub repository:** `Amruthjinesh/devops`

* **Branch:** `main`

* **Obsidian destination:** `C:\\Users\\Amruth\\Downloads\\DevOps-Learning-Vault-Updated-Day11\\DevOps-Learning-Vault-day11\\08 - Daily Logs`

* **Automation script:** `C:\\Users\\Amruth\\Scripts\\Sync-Notes-To-Obsidian.ps1`



## 2. PowerShell Basics



### Navigate to my notes folder



```powershell

cd "C:\\Users\\Amruth\\linux-system-monitor\\notes"

```



### Open a note in Notepad



```powershell

notepad day16.md

```



### Check Git status



```powershell

git -C "C:\\Users\\Amruth\\linux-system-monitor" status

```



### Understand `$env:USERPROFILE`



`$env:USERPROFILE` is a PowerShell environment variable that represents my Windows user folder.



Example:



```powershell

$env:USERPROFILE

```



Output:



```text

C:\\Users\\Amruth

```



For simplicity, I replaced `$env:USERPROFILE` in my automation script with the direct path `C:\\Users\\Amruth`.



## 3. Creating the Automation Script



Created the following file outside my Git repository:



`C:\\Users\\Amruth\\Scripts\\Sync-Notes-To-Obsidian.ps1`



The script automates four main steps:



1\. Prepare changes from the `notes` folder for Git.

2\. Commit note changes.

3\. Push the `main` branch to GitHub.

4\. Copy missing Markdown notes into Obsidian after a successful push.



### Commit message



The script uses this commit message:



```text

Update DevOps notes

```



The commit command is:



```powershell

git -C $RepoRoot commit -m "Update DevOps notes" -- notes

```



The script stages changes only in the `notes` folder.



## 4. PowerShell Execution Policy



Initially, PowerShell blocked the script because script execution was disabled.



I allowed execution for the current PowerShell session using:



```powershell

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

```



Verified the current setting using:



```powershell

Get-ExecutionPolicy -Scope Process

```



Output:



```text

Bypass

```



**Important:** The `Process` scope applies to the current PowerShell session and resets when that session closes.



## 5. Validating the Script



Checked the PowerShell syntax before executing the script.



Result:



```text

Syntax OK

```



Checked the Git repository:



```powershell

git -C "C:\\Users\\Amruth\\linux-system-monitor" status

```



Result:



```text

On branch main

Your branch is up to date with 'origin/main'.



nothing to commit, working tree clean

```



## 6. Running the Automation



Executed the script using:



```powershell

\& "C:\\Users\\Amruth\\Scripts\\Sync-Notes-To-Obsidian.ps1"

```



### Results



* GitHub push succeeded.

* Git reported `Everything up-to-date`.

* Eight Markdown notes were copied into Obsidian.

* Eight existing Obsidian files had different contents and were preserved.

* No existing conflicting files were overwritten.



### Notes copied



* `day8.md`

* `day10.md`

* `day11.md`

* `day12.md`

* `day13.md`

* `day14.md`

* `day15.md`

* `day16.md`



### Conflicts preserved



* `day1.md`

* `day2.md`

* `day4.md`

* `day5.md`

* `day6.md`

* `day7.md`

* `day9.md`

* `jenkins-webhook.md`



The script reports conflicts instead of overwriting existing Obsidian files with different content.



## 7. My New Workflow



### Step 1 — Navigate to notes



```powershell

cd "C:\\Users\\Amruth\\linux-system-monitor\\notes"

```



### Step 2 — Open or create a note



```powershell

notepad day17.md

```



Save the note using `Ctrl + S`.



### Step 3 — Run the automation



```powershell

\& "C:\\Users\\Amruth\\Scripts\\Sync-Notes-To-Obsidian.ps1"

```



The script handles the Git commit, GitHub push, and Obsidian sync.



I do not need to run `git push` separately when using this workflow.



## 8. Important Git Concepts Learned



* **Working tree:** Files and changes in my local repository.

* **Staging:** Selecting changes for the next commit.

* **Commit:** Saving a snapshot of changes in Git history.

* **Push:** Uploading local commits to GitHub.

* **Branch:** A line of development, currently `main`.

* **Commit message:** A short description of the changes, currently `Update DevOps notes`.

* **Git status:** Shows changes and branch synchronization state.



## 9. Safety Features and Limitations



* The script stages changes only from the `notes` folder.

* It attempts to push `main` to GitHub before syncing Obsidian.

* If the push fails, Obsidian synchronization is skipped.

* Existing Obsidian files with different contents are not overwritten.

* The script runs manually; it does not run in the background.

* The script pushes the entire `main` branch, including any already-committed changes on that branch.

* If GitHub rejects a push because the branches have diverged, synchronization stops and the Git issue must be resolved.



## 10. Cleanup



Removed the temporary automation experiment created earlier:



* `C:\\Users\\Amruth\\Obsidian-Automation`

* `C:\\Users\\Amruth\\Notepad-Inbox`

* The `Automation-Test.md` test copy was confirmed absent from the Obsidian destination.



The final automation script is stored separately in `C:\\Users\\Amruth\\Scripts`.



My existing DevOps notes and GitHub repository were preserved.



## 11. What I Learned Today



* How to automate repetitive Git operations using PowerShell.

* How to run a `.ps1` script.

* How PowerShell execution policies affect script execution.

* How to validate PowerShell syntax.

* How Git stages, commits, and pushes changes.

* How to copy Markdown files between folders.

* How to protect existing files by detecting content conflicts.

* How to build a lightweight workflow without Docker, Jenkins, or a background service.



### Final Summary



I created and tested a PowerShell script that pushes my existing DevOps notes to GitHub and copies missing Markdown files into Obsidian after a successful push. The script preserves conflicting files and reports them for manual resolution.



**Status:** Automation created, syntax validated, and first run successful.





