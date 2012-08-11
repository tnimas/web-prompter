<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    public struct IC
    {
        public string strana;
        public string id;
        public string prav;
        public int NW;
        public int ga;
        public int oil;
        public int rashod;
        public int spik;
        public int troop;
        public int jet;
        public int turret;
        public int tank;
        public byte tspy;
        public byte twar;
        public string oon;
        public string union;
        public double kspal;
        public double kwar;
        public double kredin;
        public double GS;
        public double BR;
        public double AB;
        public double SS;
        public double PS;
        public int spal;
        public byte readin;
        public bool res;
    }
    
        public const string rus = "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮйцукенгшщзхъфывапролджэячсмитьбю";
        public const string eng = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm";
        public const string zif = "0123456789";
        public const int KStran = 8;

        public IC[] A = new IC[KStran];
        public string strana;
        public string NewStr(string Ish, string PosStr)
        {

            string st = Ish.Substring(Ish.IndexOf(PosStr) - 1 + PosStr.Length);
            st = st.Substring(1, st.IndexOf("\n") - 1);
            return st;

        }
        public string Pars(string str, string ps, bool action)
        {
            string res = "";

            if (action)
            {
                foreach (char c in str)
                    if (ps.IndexOf(c) > -1)
                    {
                        res += c;
                    }

            }
            else
            {
                foreach (char c in str)
                    if (ps.IndexOf(c) == -1)
                    {
                        res += c;
                    }
            }
            return res;

        }
        public string Pars(string str)
        {
            return Pars(str, "0123456789", true);
        }
        public string Pars(string str,string ps)
        {
            return Pars(str, ps, true);
        }       
        public void m2(ref int a1, int a2, int a3, int a4)
        {
            if (a1 < (a2 * 0.25 + a3 * 0.25 + a4 * 0.25)) a1 += a1;
            else a1 += (int)(a2 * 0.25 + a3 * 0.25 + a4 * 0.25);
            

        }
        public void m2(ref int a1, int a2, int a3)
        {
            m2(ref a1, a2, 0, 0);
        }
    
        public void m2(ref int a1, int a2)
        {
            m2(ref a1,a2,0,0);
        }
    
        public void oil(ref IC A)
        {
            A.oil = A.oil * 40;
            if (A.oil + 1 > A.jet) A.oil -= A.jet; else { A.jet = A.oil; A.oil = 0; }

        }

        public double koef(IC A)
        {
            return (double)(A.kwar * A.kredin * A.twar / 100);
        }
        public void Prav(ref IC A)
        {
            switch (A.prav)
            {
                case "Диктатура": A.kwar = 1.25; A.kspal = 1.3;
                    break;
                case "Республика": A.kwar = 0.9;
                    break;
                case "Dictatorship": A.kwar = 1.25; A.kspal = 1.3;
                    break;
                case "Republic": A.kwar = 0.9;
                    break;
                default: A.kwar = 1; A.kspal = 1;
                    break;
            }
        }

        public void Podschet(ref IC[] A)
        {

            oil(ref A[5]);
            oil(ref A[6]);
            oil(ref A[7]);
            int buf = A[4].jet;
            m2(ref A[4].jet, A[5].jet, A[6].jet, A[7].jet);
            int souz = A[4].jet - buf;
            A[4].jet = buf;
            Prav(ref A[1]);
            Prav(ref A[4]);

            A[1].kredin = (double)A[1].readin / 100 * 0.5 + 0.5;
            A[4].kredin = (double)A[4].readin / 100;


            A[1].spal = (int)Math.Round(A[1].spik / A[1].ga * A[1].tspy * (A[1].kspal) / 100);
            A[1].GS = Math.Round(A[1].troop * koef(A[1]) / koef(A[4]) + 1000);
            A[1].BR = Math.Round(A[1].turret * koef(A[1]) / koef(A[4]) + 1000);
            A[1].AB = Math.Round(A[1].tank * koef(A[1]) / koef(A[4]) + 1000);

            m2(ref A[1].troop, A[2].troop, A[3].troop);
            m2(ref A[1].turret, A[2].turret, A[3].turret);
            m2(ref A[1].tank, A[2].tank, A[3].tank);
            A[1].SS = Math.Round(koef(A[1]) * (A[1].troop / 2 + A[1].turret + A[1].tank * 2) / koef(A[4]));
            if ((int)(souz * koef(A[4]) - 1) > (int)(A[1].SS / 2)) { A[1].SS = A[1].SS / 2; }
            else A[1].SS = (A[1].SS - souz * koef(A[4])) / 2 + A[1].SS / 2;
            A[1].SS = Math.Round(A[1].SS) + 1000;
            A[1].PS = Math.Round(A[1].SS / 1.5);

            if (A[1].rashod > A[1].ga * 10) { A[1].union = "да"; A[1].oon = "?"; }
            else if ((A[1].rashod < A[1].ga * 10) && (A[1].rashod > 0)) { A[1].union = "да"; A[1].oon = "нет"; }
            else if (A[1].rashod == A[1].ga * 10) { A[1].union = "нет"; A[1].oon = "да"; }
            else { A[1].union = "нет"; A[1].oon = "нет"; }


        }


        public bool Raspr(ref IC A, int i)
        {

            switch (i)
            {
                case 3: i = 2;
                    break;
                case 4: i = 3;
                    break;
                case 5: i = 4;
                    break;
                case 6: i = 4;
                    break;
                case 7: i = 4;
                    break;

            }
            if (i > 4) { return false; }

            if (A.strana != null)
            {
                try
                {


                    A.troop = Convert.ToInt32(Pars(NewStr(A.strana, "Пехота")));
                    if ((i != 2) | (i != 1))
                    {
                        A.jet = Convert.ToInt32(Pars(NewStr(A.strana, "Самолеты")));
                    }
                    if ((i != 4) | (i != 3))
                    {
                        A.turret = Convert.ToInt32(Pars(NewStr(A.strana, "Зенитки")));
                    }
                    A.tank = Convert.ToInt32(Pars(NewStr(A.strana, "Танки")));

                    switch (i)
                    {
                        case 1:
                            {

                                A.strana = A.strana.Remove(A.strana.IndexOf("Военная"), 7);
                                string buf = Pars(NewStr(A.strana, "Военная"));
                                buf = buf.Substring(buf.Length - 3);

                                A.twar = Convert.ToByte(buf);
                                buf = Pars(NewStr(A.strana, "Шпионаж"));
                                buf = buf.Substring(buf.Length - 3);

                                A.tspy = Convert.ToByte(buf);
                                A.id = Pars(NewStr(A.strana, "отчет по стране "), eng + zif + "()#");
                                A.rashod = Convert.ToInt32(Pars(NewStr(A.strana, "Альянсы/ООН")));
                                A.ga = Convert.ToInt32(Pars(NewStr(A.strana, "Земля")));
                                A.spik = Convert.ToInt32(Pars(NewStr(A.strana, "Шпионы")));
                                A.prav = Pars(NewStr(A.strana, "Правительство"), rus);

                            }
                            break;
                        case 3:
                            {

                                A.strana = A.strana.Remove(A.strana.IndexOf("Военная"), 7);
                                string buf = Pars(NewStr(A.strana, "Военная"));
                                buf = buf.Substring(buf.Length - 3);
                                A.twar = Convert.ToByte(buf);
                                A.prav = Pars(NewStr(A.strana, "Правительство"), rus);
                                A.oil = Convert.ToInt32(Pars(NewStr(A.strana, "Нефть")));
                            }
                            break;
                        case 4:
                            {
                                A.oil = Convert.ToInt32(Pars(NewStr(A.strana, "Нефть")));

                            }
                            break;
                        case 2:
                            { }
                            break;


                    } A.res = true;
                    return true;
                }
                catch { return false; }


            }
            else { return false; }
        }
        public void Default(ref IC A, int i)
        {
            A.res = false;
            switch (i)
            {
                case 3: i = 2;
                    break;
                case 4: i = 3;
                    break;
                case 5: i = 4;
                    break;
                case 6: i = 4;
                    break;
                case 7: i = 4;
                    break;

            }

            switch (i)
            {
                case 2: { A.troop = 0; A.turret = 0; A.tank = 0; A.readin = 100; }
                    break;
                case 3: { A.troop = 0; A.jet = 0; A.tank = 0; A.jet = 0; A.oil = 0; A.twar = 100; A.prav = "Монархия"; }
                    break;
                case 4: { A.troop = 0; A.jet = 0; A.tank = 0; A.readin = 100; A.oil = 0; }
                    break;
            }
        }

        public string Vivod(IC A, bool def1, bool def2, bool mainc, bool nast1, bool nast2, bool nast3)
        {
            string[] Ar = new string[15];
            Ar[0] = "Цель: " + A.id + " - " + A.prav;
            Ar[1] = "Стандартная атака: " + A.SS;
            Ar[2] = "Спланированная атака: " + A.PS;
            Ar[3] = "Пехотный рейд: " + A.GS;
            Ar[4] = "Авианалет: " + A.BR;
            Ar[5] = "Танковый удар: " + A.AB;
            Ar[6] = "Спал цели: " + A.spal;
            Ar[7] = "Наличие ООН\\Союзов: " + A.oon + "\\" + A.union;
            int f = 9;
            string uch = "Страна противника";
            if (mainc) uch += ", Ваша страна";
            if ((def1) && (def2)) uch += ", 2 защитных союза";
            else
                if (def1) uch += ", 1ый защитный союз";
                else if (def2) uch += ", 2ой защитный союз";
            if (nast1 && nast2 && nast3) uch += ", 3 наступательных союза";
            else if (nast1 && nast2) uch += ", 1 и 2 наступательный союзы";
            else if (nast1 && nast3) uch += ", 1 и 3 наступательный союзы";
            else if (nast2 && nast3) uch += ", 2 и 3 наступательный союзы";
            else if (nast1) uch += ", 1 наступательный союз";
            else if (nast2) uch += ", 2 наступательный союз";
            else if (nast3) uch += ", 3 наступательный союз";



            if (uch.Length > 20)
                Ar[f] = "**При подсчете учтены: " + uch;
            else f--;
            f++;
            if (mainc == false)
            {
                Ar[f] = "***Пробой для вашей страны может существенно отличаться от указанного, чтобы увидеть точный пробой, укажите " +
                         "статистику по своей стране в соответствующей графе.";
                f++;
            }
            if (A.union == "да")
            {
                if ((def1 == false) || (def2 == false))
                {
                    Ar[f] = "***Внимание! Цель имеет союзы, пробой для Стандартной и Спланированной атак может быть больше указанного." +
                            " Если у вас есть шпионажи защитных союзов цели, укажите их для подсчета точного прообоя";
                    f++;
                }
            }
            if ((nast1 == false) && (nast2 == false) && (nast3 == false))
            {
                Ar[f] = "***Вы также можете указать ваши наступательные союзы для подсчета минимального пробоя для Стандартной\\Спланированной атак";

                f++;

            }

            A.strana = "";
            for (int i = 0; i < f; i++)
            {
                A.strana += Ar[i] + "\n";
            }



            return A.strana;
        }


        protected void SendB_Click(object sender, EventArgs e)
        {

            
            
            try
            {
                A[1].strana = OText.Text;
                A[2].strana = TDef1.Text;
                A[3].strana = TDef2.Text;
                A[4].strana = TMainC.Text;
                A[5].strana = TNast1.Text;
                A[6].strana = TNast2.Text;
                A[7].strana = TNast3.Text;
                if ( Convert.ToInt16(Readin.Text) > 100 )  Readin.Text = "100";  
                if ( Convert.ToInt16(Readin0.Text) > 100 ) Readin0.Text = "100";
                A[1].readin = Convert.ToByte(Readin0.Text);
                A[4].readin = Convert.ToByte(Readin.Text);
                
                
                for (int i = 1; i < KStran; i++)
                {

                    if (Raspr(ref A[i], i) == false)
                    {
                        if (i == 1)
                        {

                            A[1].res = false;
                            VText.Text = "Скопируйте шпионаж по цели в графу \"Страна противника\"";
                        }
                        else Default(ref A[i], i);

                    }
                }

                if (A[1].res)
                {
                    Podschet(ref A);
                    A[1].strana = Vivod(A[1], A[2].res, A[3].res, A[4].res, A[5].res, A[6].res, A[7].res);
                    VText.Text = A[1].strana;
                }
            }
            catch { VText.Text = "При обработке данных произошла ошибка."; }

            if (VText.Text.Length == 0) { VText.Text = "Скопируйте шпионаж по цели в графу \"страна противника\""; }



        }




        //onclick="if(OText.value=='Вставьте шпионаж по стране противника') { OText.value=''; }"


</script>


<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>




    <style type="text/css">
        #Button1
        {
            width: 160px;
            height: 30px;
        }

    </style>




    <script language="javascript" type="text/javascript">
// <![CDATA[

        function Button1_onclick() {
            document.getElementById("VText").value = "Для начала работы скопируйте  шпионаж по цели в графу слева. Для уточнения вычислений вы можете скопировать данные шпионажей \\ статистики \\ информации о союзнике в соответствующие графы. Далее нажмите кнопку \"Обработать\". Очищение полей производится нажатием левой кнопки мыши  на нужном поле и обновлением страницы (для всех полей сразу)";
            document.getElementById("OText").value = "";
            document.getElementById("TMainC").value = "";
            document.getElementById("TNast1").value = "";
            document.getElementById("TNast2").value = "";
            document.getElementById("TNast3").value = "";
            document.getElementById("TDef1").value = "";
            document.getElementById("TDef2").value = "";
            document.getElementById("Readin").value = "100";
            document.getElementById("Readin0").value = "100";
            return true;
        }
        function clicked(s) {
            
            
            if (document.getElementById("cbox").checked != true) document.getElementById(s).value = "";
            
            return true;
        }
        function setCookie(name, value) {
            document.cookie = name + "=" + escape(value);
        }

        function getCookie(name) {
            var cookie = " " + document.cookie;
            var search = " " + name + "=";
            var setStr = null;
            var offset = 0;
            var end = 0;
            if (cookie.length > 0) {
                offset = cookie.indexOf(search);
                if (offset != -1) {
                    offset += search.length;
                    end = cookie.indexOf(";", offset)
                    if (end == -1) {
                        end = cookie.length;
                    }
                    setStr = unescape(cookie.substring(offset, end));
                }
            }
            return (setStr);
        }

        $(document).ready(function () {
            cok = getCookie("checked");
            document.getElementById("cbox").checked = cok;
        });

        function setcbox() {
           
            setCookie("checked", document.getElementById("cbox").checked);
        }




// ]]>
    </script>
</head>
<body>
    <form id="form1" runat="server">
   <table>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center"
                            style="font-family: 'Times New Roman'; font-size: 14pt">
                            Данные шпионажа
                <br />
                            по стране противника</td>
                        <td align="center">
                            &nbsp;</td>
                        <td 
                            style="font-family: 'Times New Roman', Times, serif; font-size: 14pt;" 
                            align="center">
                Вывод информации по стране противника</td>
                        <td 
                            style="font-family: 'Times New Roman', Times, serif; font-size: 14pt;" 
                            align="center">
                            Защитные союзы<br />
                            противника</td>
                    </tr>
                    <tr>
                        <td align="center">

                            <table style="width:100%;">
                                <tr>
                                    <td>

                <asp:TextBox ID="OText" runat="server" Height="140px" TextMode="MultiLine" onclick="clicked(this.id)" 
                    Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" 
                                        style="font-family: 'Times New Roman'; font-size: 14pt">
                                        Данные статистики вашей страны</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TMainC" runat="server" Height="140px" TextMode="MultiLine" onclick="clicked(this.id)" 
                                            Width="305px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="center">

                            &nbsp;</td>
                        <td>
                <asp:TextBox ID="VText" runat="server" Height="310px" Width="450px"  
                    TextMode="MultiLine">Для начала работы скопируйте  шпионаж по цели в графу слева. Для уточнения вычислений вы можете скопировать данные шпионажей \ статистики \ информации о союзнике в соответствующие графы. Далее нажмите кнопку &quot;Обработать&quot;. Очищение полей производится нажатием левой кнопки мыши  на нужном поле и обновлением страницы (для всех полей сразу)</asp:TextBox>

                        </td>
                        <td>
                            <table style="width:100%;">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TDef1" runat="server" TextMode="MultiLine" Width="300px" 
                                            onclick="clicked(this.id)" Height="54px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td >
                                        <asp:TextBox ID="TDef2" runat="server" TextMode="MultiLine" Width="300px" 
                                            onclick="clicked(this.id)" Height="54px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td  style="font-family: 'Times New Roman', Times, serif; font-size: 14pt;" 
                            align="center">
                                        Ваши наступательные 
                                        <br />
                                        союзы</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TNast1" runat="server" TextMode="MultiLine" Width="300px" onclick="clicked(this.id)"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TNast2" runat="server" TextMode="MultiLine" Width="300px" onclick="clicked(this.id)"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TNast3" runat="server" TextMode="MultiLine" Width="300px" onclick="clicked(this.id)"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                 Ваша 
                боеготовность:</td>
                        <td align="left">
                <asp:TextBox ID="Readin" runat="server" Width="27px" Height="25px">100</asp:TextBox>
                        </td>
                        <td align="left">
                            &nbsp;</td>
                        <td align="left" >
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center">
                Боеготовность противника:</td>
                        <td align="left">
                <asp:TextBox ID="Readin0" runat="server" Width="27px" Height="25px">100</asp:TextBox>
                        </td>
                        <td align="center">
                <asp:Button ID="SendB" runat="server" Text="Обработать" onclick="SendB_Click" 
                    Width="160px" Height="30px" Font-Italic="False" Font-Names="Arial" 
                                Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        </td>
                        <td align="left">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td align="center">
                            <br />
                        </td>
                        <td align="center">
                            </td>
                        <td align="center">
                            <input id="Button1" type="button" value="Обнулить" 
                                onclick="return Button1_onclick()" /></td>
                        <td>
                            </td>
                    </tr>
                </table>


    <asp:CheckBox ID="cbox" runat="server" 
        Text="Не очищать поля нажатием левой кнопки мыши" 
        onclick="setcbox()"/>
&nbsp;<br />

       




    </form>


</body>
</html>