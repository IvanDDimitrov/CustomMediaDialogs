<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI.ControlDesign" TagPrefix="sf" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI" TagPrefix="sf" %>
<%@ Register Assembly="Telerik.Sitefinity" TagPrefix="sfFields" Namespace="Telerik.Sitefinity.Web.UI.Fields" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Modules.Libraries.Web.UI.Designers" TagPrefix="sf" %>
<%@ Register Assembly="SitefinityWebApp" Namespace="SitefinityWebApp"  TagPrefix="test" %>
<sfFields:FormManager id="formManager" runat="server"/>

<sf:SitefinityLabel runat="server" id="titleLabel" WrapperTagName="h1" CssClass="sfSepTitle"></sf:SitefinityLabel>
<div class="sfBasicDim">
    <div runat="server" id="mediaContentManagerWrapper" class="sfContentViews">
        <sf:SingleMediaContentItemView id="contentSelectorView" runat="server" UseSmallItemPreview="true" SkipBlankItemView="true" ShowCropResizeRotateButton="true"></sf:SingleMediaContentItemView>

        <sfFields:TextField ID="titleTextField" runat="server" DisplayMode="Write" CssClass="sfFormCtrl sfW335" ShowCharacterCounter="true"
            RecommendedCharactersCount="35"
            CharacterCounterDescription="<%$Resources:PageResources, CharacterCounterDescription%>"
            Title="<%$Resources:Labels, ImageTitleWithNote %>" />
        <sfFields:TextField ID="altTextField" runat="server" DisplayMode="Write" CssClass="sfFormCtrl sfW335" ShowCharacterCounter="true"
                        RecommendedCharactersCount="35"
                        CharacterCounterDescription="<%$Resources:PageResources, CharacterCounterDescription%>"
            Title="<%$Resources:Labels, AlternativeTextWithNote %>" />

        <sf:SingleMediaContentItemSettingsView id="itemSettingsView" ShowAlignmentOptions="true" runat="server"></sf:SingleMediaContentItemSettingsView>
    </div>
</div>
<div id="buttonArea" class="sfButtonArea sfSelectorBtns" runat="server">
    <asp:HyperLink runat="server" id="saveLink" class="sfLinkBtn sfSave sfDisabledLinkBtn">
        <sf:SitefinityLabel runat="server" id="saveLinkTitle" class="sfLinkBtnIn" Text="<%$Resources:Labels, Save %>" WrapperTagName="strong"/>
    </asp:HyperLink>
    <asp:Literal runat="server" ID="lOr" Text="<%$Resources:Labels, or %>" />
    <asp:HyperLink id="cancelLink" class="sfCancel" runat="server" NavigateUrl="javascript:void(0);">
        <sf:SitefinityLabel runat="server" id="cancelLinkTitle" Text="<%$Resources:Labels, Cancel %>"></sf:SitefinityLabel>
    </asp:HyperLink>
</div>
<sf:ClientLabelManager id="clientLabelManager" runat="server">
	<Labels>
		<sf:ClientLabel ClassId="Labels" Key="Save" runat="server" />
		<sf:ClientLabel ClassId="Labels" Key="Upload" runat="server" />
		<sf:ClientLabel ClassId="Labels" Key="Done" runat="server" />
		<sf:ClientLabel ClassId="ImagesResources" Key="EditImage" runat="server" />
		<sf:ClientLabel ClassId="LibrariesResources" Key="InsertAItem" runat="server" />
		<sf:ClientLabel ClassId="ImagesResources" Key="ImageWithArticle" runat="server" />
		<sf:ClientLabel ClassId="ImagesResources" Key="SelectAnImage" runat="server" />
	</Labels>
</sf:ClientLabelManager>