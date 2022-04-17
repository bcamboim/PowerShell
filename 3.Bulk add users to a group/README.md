<p> Hello everyone, as the name suggests, this code is to bulk add users to a group!</p>
<p><em>I wanted to do something more complete here so this code is a little florid. You can comment line 3 till line 15 because what it does is open a window where you can choose the CSV file with the names of the users you wish to import.</em></p>
<p><em>p.s: If you do comment these line please import the csv using the command <strong>Import-CSV</strong></em></p>

<p>This code consists of the steps:
    <ul>
        <li>Importing the list of users that you wish to move</li>
        <li>Getting the members of the group</li>
        <li>The user already belongs to group?
            <ul>
                <li>If the user does:
                    <ul>
                        <li>Show a message saying that the user already belongs to the group – There is no action to be done.</li>
                    </ul>
                </li>
                <li>If the user does not:
                    <ul>
                        <li>Add user to the group.</li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>
</p>

