<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author>Administrator</Author>
  <LastAuthor>LONG Z</LastAuthor>
  <Created>2015-09-05T10:00:07Z</Created>
  <LastSaved>2015-09-06T03:00:16Z</LastSaved>
  <Version>14.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>11595</WindowHeight>
  <WindowWidth>20400</WindowWidth>
  <WindowTopX>0</WindowTopX>
  <WindowTopY>0</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s41" ss:Name="常规 2">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font ss:FontName="Arial" x:Family="Swiss"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s63" ss:Parent="s41">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
   </Borders>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="12" ss:Color="#000000"
    ss:Bold="1"/>
   <Interior ss:Color="#BFBFBF" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s65" ss:Parent="s41">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"
     ss:Color="#000000"/>
   </Borders>
  </Style>
 </Styles>
 <Worksheet ss:Name="新员工课程安排">
  <Table ss:ExpandedColumnCount="11"  x:FullColumns="1"
   x:FullRows="1">
   <Column ss:Width="180.75"/>
   <Column ss:Width="59.25"/>
   <Column ss:Width="102"/>
   <Column ss:Width="57.75"/>
   <Column ss:Width="34.5"/>
   <Column ss:Width="75"/>
   <Column ss:AutoFitWidth="0" ss:Width="52.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="120.75"/>
   <Column ss:AutoFitWidth="0" ss:Width="70.5"/>
   <Column ss:AutoFitWidth="0" ss:Width="121.5"/>
   <Column ss:Width="59.25"/>
   <Row ss:Height="15.75">
    <Cell ss:StyleID="s63"><Data ss:Type="String">项目名称</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">培训地点</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">专业名称</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">日期</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">时段</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">班级名称</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">组别</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">课程名称</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">教师</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">教室</Data></Cell>
    <Cell ss:StyleID="s63"><Data ss:Type="String">授课方式</Data></Cell>
   </Row>
   <#list dataN as xx1>
   <Row>
    <Cell><Data ss:Type="String">${xx1.projectName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.pxdd}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.majorName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.kcdate}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.period}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.className}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.groupName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.courseName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.teacherName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.roomName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx1.trainType}</Data></Cell>
   </Row>
   </#list> 
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>0</PaperSizeIndex>
    <VerticalResolution>0</VerticalResolution>
    <NumberofCopies>0</NumberofCopies>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>1</ActiveRow>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <Sorting xmlns="urn:schemas-microsoft-com:office:excel">
   <Sort>培训地点</Sort>
   <Sort>班级名称</Sort>
  </Sorting>
 </Worksheet>
 <Worksheet ss:Name="短期班课程安排">
  <Table ss:ExpandedColumnCount="9"  x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="85.5">
   <Column ss:Width="235.5"/>
   <Column ss:Width="59.25"/>
   <Column ss:Width="57.75"/>
   <Column ss:Width="34.5"/>
   <Column ss:Width="252"/>
   <Column ss:Width="34.5"/>
   <Column ss:Width="69"/>
   <Column ss:Width="145.5"/>
   <Column ss:Width="102"/>
   <Row ss:Height="15.75">
    <Cell ss:StyleID="s64"><Data ss:Type="String">项目名称</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">培训地点</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">日期</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">时段</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">班级名称</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">组别</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">课程名称</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">教师</Data></Cell>
    <Cell ss:StyleID="s64"><Data ss:Type="String">教室</Data></Cell>
   </Row>
  <#list dataS as xx>
   <Row>
    <Cell><Data ss:Type="String">${xx.projectName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.pxdd}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.kcDate}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.period}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.className}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.groupName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.courseName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.teacherName}</Data></Cell>
    <Cell><Data ss:Type="String">${xx.roomName}</Data></Cell>
   </Row>
   </#list>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Print>
    <ValidPrinterInfo/>
    <HorizontalResolution>300</HorizontalResolution>
    <VerticalResolution>300</VerticalResolution>
   </Print>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>2</ActiveRow>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
