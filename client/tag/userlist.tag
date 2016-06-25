<userlist>
  <h1>GAME</h1>
   <div id = userlist>
    <li each = { users } >
        <p>NAME : {value.name}</p>
        <div if={value.ready}>準備完了</div>
    </li>
   </div>
   <script>
    this.users = opts.users; 
   </script>
</userlist>