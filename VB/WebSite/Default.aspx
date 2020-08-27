<%@ Page Language="vb" AutoEventWireup="true"  CodeFile="Default.aspx.vb" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>ListBox</title>
</head>
<body>
<script type="text/javascript" language="javascript">
		//-----------------------------------------------------------------------------
		var maximumItemsCount = 6;
		var timerID = -1;
		var lastSelectedIndices = new Array(); //Array of indices which should be unselected
		var currentSelectedIndices = new Array(); //Array of indices which already selected
		var hasSelectionEvent = false; //Detect selection event
		//-----------------------------------------------------------------------------
		//Reset timer which was set up during group selection operation
		function ResetTimer(timerID) {
			if (timerID > -1)
				window.clearTimeout(timerID);
			return -1;
		}
		//-----------------------------------------------------------------------------
		//Save current selected indices
		function SaveCurrentSelectedIndices() {
			currentSelectedIndices = clientListBoxDemo.GetSelectedIndices();
		}
		//-----------------------------------------------------------------------------
		//Occurs after a different item in the list box has been selected/unselected
		function ProcessSelection(s, e) {
			if (e.isSelected) {
				hasSelectionEvent = true;
				lastSelectedIndices.push(e.index); //Add new index which should be unselect if it necessary
			}
			ResetTimer(timerID);
			timerID = setTimeout(ValidateListbox, 100); //Set up new timer for each event during group selection operation
		}
		//-----------------------------------------------------------------------------
		//Validate list box. Unselect superfluous indices if it necessary
		function ValidateListbox() {
			clientLabelError.SetVisible(false);
			if (hasSelectionEvent) {
				hasSelectionEvent = false;
				clientListBoxDemo.SelectIndices(currentSelectedIndices); //Restore all indices which should not be unselected
				var selectedIndices = clientListBoxDemo.GetSelectedIndices();
				var superfluousIndicesCount = selectedIndices.length - maximumItemsCount;
				if (superfluousIndicesCount > 0) { //If exist superfluous indices
					var superfluousIndices = new Array();
					for (var i = 0; i < superfluousIndicesCount; i++)
						superfluousIndices.push(lastSelectedIndices.pop());
					clientListBoxDemo.UnselectIndices(superfluousIndices); //Unselect superfluous indices
					clientLabelError.SetVisible(true);
				}
			}
			SaveCurrentSelectedIndices();
		}
		//-----------------------------------------------------------------------------
	</script>
	<form id="mainForm" runat="server">
	<div>
		<dx:ASPxLabel ID="ASPxLabelDemo" runat="server" Text="Try to select more than 6 items">
		</dx:ASPxLabel>
		<dx:ASPxListBox ID="ASPxListBoxDemo" runat="server" ClientInstanceName="clientListBoxDemo"
			Height="400px" Width="200px" SelectionMode="CheckColumn" SelectedIndex="0">
			<Items>
				<dx:ListEditItem Text="Item 1" Value="1" Selected="true" />
				<dx:ListEditItem Text="Item 2" Value="2" />
				<dx:ListEditItem Text="Item 3" Value="3" Selected="true"/>
				<dx:ListEditItem Text="Item 4" Value="4" />
				<dx:ListEditItem Text="Item 5" Value="5" Selected="true" />
				<dx:ListEditItem Text="Item 6" Value="6" />
				<dx:ListEditItem Text="Item 7" Value="7" Selected="true"/>
				<dx:ListEditItem Text="Item 8" Value="8" />
				<dx:ListEditItem Text="Item 9" Value="9" Selected="true" />
				<dx:ListEditItem Text="Item 10" Value="10" />
				<dx:ListEditItem Text="Item 11" Value="11" Selected="true"/>
				<dx:ListEditItem Text="Item 12" Value="12" />
				<dx:ListEditItem Text="Item 13" Value="13" />
				<dx:ListEditItem Text="Item 14" Value="14" />
				<dx:ListEditItem Text="Item 15" Value="15" />
			</Items>
			<ClientSideEvents 
			SelectedIndexChanged="function(s, e) {
				ProcessSelection(s, e);
			}" 
			Init="function(s, e) {
				SaveCurrentSelectedIndices();
			}" />
		</dx:ASPxListBox>

	<dx:ASPxLabel ID="ASPxLabelError" runat="server" 
		Text="You can select maximum 6 records" ClientInstanceName="clientLabelError" 
		ForeColor="#FF3300">
	</dx:ASPxLabel>

	</div>
	</form>
</body>
</html>