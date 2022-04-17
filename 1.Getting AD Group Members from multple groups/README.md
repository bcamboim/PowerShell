<p> Hello everyone, we always get this task where the company X asks us to extract the members of a AD group</p>
<p>So I decided to automate it a little bit because using the command <strong>Get-ADGroupMember</strong> and writing down the name of each group manually sucks!</p>
<p><em>I overdid it, I confess! You can run this code and it will open all sorts of windows for you to choose a file and choose where to save the exported file!</em></p>

<p>This code consists of the steps:
    <ul>
        <li>Importing a TXT file that contains the name of the groups. <em>The names of the groups have to be ordered in a column, check for empty spaces as well</em></li>
        <li>Getting the names that were imported and putting them in an array variable. <em>p.s: It was one of my first codes and I found myself facing the problem where the Foreach command was not working to interact with each line of the TXT file and do the required action, so my solution was, at the time, to do a create the array containing the name of the groups so I could interact with each index of the array later and do the action of getting the group member.</em></li>
        <li>Walking through the array of names of the groups and executing the actions 
            <ul>
                <li>Does the name match any AD Group?
                    <ul>
                        <li>If it does: Get the group members</li>
                        <li>If it does not: Write-Warning saying that the group does not exist or was not found</li>
                    </ul>
                </li>
            </ul>
        </li>
        <li>Asks if you want to export the name of the groups that were not found.
            <ul>
                <li>If yes: opens a window where you can choose the name of the file and the directory where you want to save it.</li>
                <li>If not: Does literally nothing.</li>
            </ul>
        </li>
        <li>Opens a window where you can choose the directory to save and the name of the CSV file containing the group members</li>
    </ul>
</p>

