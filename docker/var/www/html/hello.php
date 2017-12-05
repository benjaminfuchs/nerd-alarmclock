<form action="/cgi-bin/hello.py" method="POST">

    <textarea name="post" cols=70 rows=5>
<?php
echo file_get_contents('/var/nerdc_home/settings.json');
?>
    </textarea><br>

    <input type="submit" value="Submit">
    <input type="reset" value="Reset">

</form>
