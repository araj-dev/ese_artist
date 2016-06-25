<enter>
    <h1>ENTER YOUR NAME</h1>
    <input id="name" type="text" ref="name" placeholder="your name...">
    <input type="button" onclick = {handleEnter} value="ENTER">
    <script>
        this.handleEnter = function(){
            var name = $('#name').val();
            opts.enterroom(name);
        };
    </script>
</enter>