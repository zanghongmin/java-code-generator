$(function () {

    /**
     * 初始化 table sql
     */
    var tableSqlIDE;
    function initTableSql() {
        tableSqlIDE = CodeMirror.fromTextArea(document.getElementById("tableSql"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-sql",
            lineWrapping:false,
            readOnly:false,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        tableSqlIDE.setSize('auto','auto');
    }
    initTableSql();

    /**
     * 生成代码
     */
    $('#codeGenerate_zip').click(function () {

        var tableSql = tableSqlIDE.getValue();

        $.ajax({
            type : 'POST',
            url : base_url + "/codeGenerate_zip",
            data : {
                "tableSql" : tableSql,
                "groupId" : document.getElementById("groupId").value,
                "artifactId" : document.getElementById("artifactId").value,
                "description" : document.getElementById("description").value,
                "springbootversion" : document.getElementById("springbootversion").value
            },
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    location.href = base_url +"/downloadzip?name=" +data.data;
                } else {
                    alert(data)
                }
            }
        });

    });


});