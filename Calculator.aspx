<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calculator.aspx.cs" Inherits="Task1.Calculator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .btn {
            background-color: grey;
            color: white;
            font-size: large;
            font-weight: bolder;
            border: hidden;
            border-radius: 3px;
            padding: 2px 15px;
            font-size:40px;
            margin: 3px;
        }
        .symbolBtn {
            background-color: #FE9505;
            color: white;
            font-size: large;
            font-weight: bolder;
            border: hidden;
            border-radius: 3px;
            padding: 2px 15px;
            font-size:40px;
            margin: 3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width:100%; display: flex; flex-direction: column; align-items:center; justify-content:center;">
            <div style="width: 265px; height:40%; border: solid; margin-top:60px; border-radius:10px;">
                <div style="background-color: black; color: white; font-size:x-large; font-weight:bold; display:flex">
                    <p id="history" style=" margin-left: 10px;"><i class="fa fa-bars" aria-hidden="true"></i></p>
                    <p style="margin:12px; padding: 10px 10px;">History</p>
                </div>
                <div id="historyDiv" style="background-color:#FAFAFA; width: 260px; height:430px; position:absolute; overflow-y:scroll; display:none">
                    <table id="historyTable" style="width:100%">
                        <thead>
                            <tr>
                                <th><button id="clearHistory" style="padding: 5px 4px">Clear History</button></th>
                            </tr>
                        </thead>
                        <tbody style="padding: 5px 5px; font-size:x-large; font-weight:bold;">
                            <tr style="display:flex; flex-direction:column;">
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div>
                    <div style="width:100%; background-color: #F7F7F7">
                        <asp:TextBox ID="screenTxt" disabled="true" Width="100%" TextMode="MultiLine" Rows="4" style="padding:0; resize:none; font-size:20px;" BorderWidth="0" runat="server"></asp:TextBox>
                        <asp:TextBox ID="answerTxt" disabled="true" Width="100%" style="padding:10px 0; font-size:20px; text-align: right;" BorderWidth="0" runat="server"></asp:TextBox>
                    </div>
                    <div id="btnDiv" style="border:solid; padding:10px 0; text-align:center; background-color:black;">
                        <div>
                            <button id="Btn7" class="btn">7</button>
                            <button id="Btn8" class="btn">8</button>
                            <button id="Btn9" class="btn">9</button>
                            <button id="BtnC" class="symbolBtn" style="padding: 2px 12px;">C</button>
                        </div>
                        <div>
                            <button id="Btn4" class="btn">4</button>
                            <button id="Btn5" class="btn">5</button>     
                            <button id="Btn6" class="btn">6</button> 
                             <button id="BtnDivide" class="symbolBtn" style="padding: 2px 20px;">/</button> 
                        </div>
                        <div>
                            <button id="Btn1" class="btn">1</button>
                            <button id="Btn2" class="btn">2</button>     
                            <button id="Btn3" class="btn">3</button> 
                            <button id="BtnMultiply" class="symbolBtn">x</button>
                        </div>
                        <div>
                            <button id="Btn0" class="btn">0</button>
                            <button id="BtnPoint" class="btn" style="padding: 2px 20px;">.</button>
                            <button id="BtnSubtract" class="symbolBtn" style="padding: 2px 20px;">-</button>
                            <button id="BtnPlus" class="symbolBtn" style="padding: 2px 14px;">+</button> 
                        </div>
                        <div>
                            <div style="width:97%; margin-left:5px">
                                <button id="BtnSubmit" class="symbolBtn" style="width:35%">AC</button>
                                <button id="BtnAC" class="symbolBtn" style="width:55%">=</button>
                            </div>
                        
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </form>

    <script>
        $(function () {
            var total = 0.00;
            var numberTxt = "";
            var lastSymbol = "";
            $("#btnDiv div button").click(function () {
                event.preventDefault();
                let number = parseFloat($(this).text(), 10);
                if ($(this).text() != "C" && $(this).text() != "AC") {
                    $("#screenTxt").append($(this).text());
                    if (!isNaN(number) || $(this).text() == ".") {
                        numberTxt = numberTxt + $(this).text();
                    }
                    else {
                        var lastCharacter = $(this).text();
                        if (lastSymbol == "+") {
                            total = total + parseFloat(numberTxt, 10);
                            numberTxt = "";
                        }
                        else if (lastSymbol == "-") {
                            total = total - parseFloat(numberTxt, 10);
                            numberTxt = "";
                        }
                        else if (lastSymbol == "x") {
                            total = total * parseFloat(numberTxt, 10);
                            numberTxt = "";
                        }
                        else if (lastSymbol == "/") {
                            total = total / parseFloat(numberTxt, 10);
                            numberTxt = "";
                        }
                        else if (lastSymbol == "") {
                            total = parseFloat(numberTxt, 10);
                            numberTxt = "";
                        }
                        lastSymbol = lastCharacter;
                        if (lastCharacter == "=" || lastSymbol == "=") {
                            if (isNaN(total)) {
                                $("#answerTxt").val("Syntax Error");
                            }
                            else {
                                $("#answerTxt").val(total);
                                $("#historyTable tbody tr").append("<td class='historytd' onclick='tdClick()'>" + $("#screenTxt").text() + total + "</td>");
                                $("#historyTable tbody tr td").css({ "background-color": "cadetblue", "margin-bottom": "5px", "padding": "5px 10px" });
                            }
                            $("#screenTxt").text("");
                            numberTxt = "";
                            total = 0.0;
                            lastSymbol = "";
                        }
                    }
                }
                else {
                    if ($(this).text() == "C") {
                        var text = $("#screenTxt").val();
                        text = text.slice(0, -1);
                        numberTxt = numberTxt.slice(0, -1);
                        $("#screenTxt").text(text);
                    }
                    else if ($(this).text() == "AC") {
                        total = 0.0;
                        firstNumber = true;
                        numberTxt = "";
                        $("#screenTxt").text("");
                        $("#answerTxt").val("");
                    }
                }
            });
            $("#history").click(function () {
                $("#historyDiv").toggle("fast");
            });

            $("#historyTable").on("click", "td", function () {
                event.preventDefault();
                var textArray = $(this).text().split("=");
                $("#screenTxt").text(textArray[0]);
                $("#answerTxt").val(textArray[1]);
                total = parseFloat(textArray[1], 10);
                lastSymbol = "=";
                $("#historyDiv").toggle("fast");
            });

            $("#clearHistory").click(function () {
                event.preventDefault();
                $("#historyTable > tbody > tr").empty();
            });
        });
    </script>
</body>
</html>
