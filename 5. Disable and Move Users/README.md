<p> Hi, we always get this task where the company X asks us to disable an user and move it to a certain Organizational Unit, so I decided to automate this task a little because disabling and moving a short list of users is easy but when the list is long it takes a lot of time.</p>

<p>This code consists of the steps:
    <ul>
        <li>Importing the list of users</li>
        <li>Getting the users on Active Directory</li>
        <li>User is Enabled or Disabled?
            <ul>
                <li>If the user is disable:
                    <ul>
                        <li>User is in the right Organizational Unit – There is no action to be done.</li>
                        <li>User is in the wrong Organizational Unit – Action: Move the user to the right Organizational Unit.</li>
                    </ul>
                </li>
                <li>If the user is Enabled:
                    <ul>
                        <li>Disable the user and move it to the right OU.</li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>
</p>

