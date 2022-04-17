<p> Hello everyone, as the name suggests, this code is to extract a Log</p>
<p><em>This code is not generic and it only gets the events 4624 and 4625 and looking back it could have been. In the near future, I'll try to write a generic version.</em></p>

<p>This code consists of the steps:
    <ul>
        <li>Get the Domain controllers</li>
        <li>Read the number of the event that was inputted on the terminal. <em>p.s: It only works with the inputs 4624 and 4625, my bad!</em></li>
        <li>Read the Username that was inputted on the terminal</li>
        <li>Read the number of days you want to look for the events that were inputted on the terminal</li>
        <li>Search for the Events that match the criteria inputted
            <ul>
                <li>Select from the event information:
                    <ul>
                        <li>Username that created the event</li>
                        <li>IP that created the event</li>
                        <li>WorkStation that created the event</li>
                    </ul>
                </li>
            </ul>
        </li>
        <li>Export the information found to a CSV file</li>
    </ul>
</p>

