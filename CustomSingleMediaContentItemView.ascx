<%@ Control Language="C#" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI" TagPrefix="sf" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI.Fields" TagPrefix="sf" %>
<%@ Register TagPrefix="sitefinity" Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI" %>
<%@ Register TagPrefix="Images" Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Modules.Libraries.Web.UI.Images" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Modules.Libraries.Web.UI.Videos" TagPrefix="sfLibraries" %>
<%@ Register Assembly="Telerik.Sitefinity" Namespace="Telerik.Sitefinity.Web.UI.Fields" TagPrefix="sfFields" %>
<%@ Register Assembly="SitefinityWebApp" Namespace="SitefinityWebApp"  TagPrefix="test" %>

<sf:ResourceLinks ID="resourcesLinks" runat="server">
    <sf:ResourceFile Name="Styles/Window.css" />
    <sf:ResourceFile Name="Styles/MaxWindow.css" />
</sf:ResourceLinks>

<div class="sfDim360">
    <div id="sf_imgIsSelected" style="display: none;">
        <div id="img_container">
            <div class="sfSelImgWrp">
                <div id="sf_imgSelected" class="sfSelImg sfMTop15" style="display: none;">
                    <sf:SfImage ID="thumbnailImage" runat="server" />
                </div>
                <div  id="sf_videoSelected" class="sfPreviewVideoFrame sfSelImg sfMTop15" style="display: none;">
                    <sfFields:MediaField id="mediaField" runat="server" ItemName = "Video" ItemNamePlural = "Videos" DisplayMode="Read" HideCommandBar="true" />
                </div>
                <div id="sf_docSelected" class="sfSelDoc sfMTop15" style="display: none;">
                    <i class="sfext"></i>
                    <sf:SitefinityHyperLink ID="documentHyperLink"  runat="server" target="_blank" />
                </div>
                <div id="sf_unpublishedMediaItemMessage" class="sfSelDoc sfMTop15" style="display: none;">
                    <p class="sfUnpublishedItm"><b><asp:Literal ID="unpublishedMediaItemMessage" runat="server" /></b></p>
                </div>
                <div class="sfSelImgProps sfMTop15">
                    <ul>
                        <li><strong>
                            <asp:Literal ID="Literal4" runat="server" Text="<%$Resources:Labels, Title %>" />:</strong>
                            <asp:Label ID="lblTitle" runat="server" />
                        </li>

                        <li id="alternativeTextLabelWrapper"><strong>
                            <asp:Literal ID="Literal5" runat="server" Text="<%$Resources:ImagesResources, AlternativeText %>" />:</strong>
                            <asp:Label ID="lblAltText" runat="server" />
                        </li>
                        <li><strong>
                            <asp:Literal ID="Literal1" runat="server" Text="<%$Resources:Labels, Type %>" />:</strong>
                            <asp:Label ID="lblExtension" runat="server" />
                        </li>
                        <li><strong>
                            <asp:Literal ID="Literal2" runat="server" Text="<%$Resources:Labels, FileSize %>" />:</strong>
                            <asp:Label ID="lblSize" runat="server" />
                        </li>
                        <li><strong>
                            <asp:Literal ID="Literal3" runat="server" Text="<%$Resources:LibrariesResources, Library %>" />:</strong>
                            <asp:Label ID="lblLibrary" runat="server" />
                        </li>
                    </ul>
                    <asp:LinkButton runat="server" ID="changeImageButton" OnClientClick="return false;"  style="display:none"
                        CssClass="sfLinkBtn sfChange">
                        <strong class="sfLinkBtnIn">
                                <asp:Literal ID="changeButtonTitle" runat="server"/></strong>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="editImageButton" OnClientClick="return false;" style="display:none"
                        CssClass="sfLinkBtn sfChange">
                    <strong class="sfLinkBtnIn">
                            <asp:Literal ID="editButtonTitle" runat="server"/></strong>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="cropResizeRotateImageButton" OnClientClick="return false;" style="display:none"
                        CssClass="sfLinkBtn sfChange">
                        <strong class="sfLinkBtnIn">
                            <asp:Literal ID="Literal8" runat="server" Text="<%$Resources:Labels, CropResizeRotateDotDotDot %>" /></strong>
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div id="sf_imgIsEmpty" class="sfNoMediaItem">
        <div class="sfPTop100">
            <span class="sfMediaItemViewIcn"></span>
            <b class="sfDisplayBlock sfMTop10"><sf:SitefinityHyperLink ID="selectImageButton"  runat="server" target="_blank" /></b>
            <sf:SitefinityHyperLink ID="uploadImageButton" runat="server" target="_blank" CssClass="sfSmallerTxt" />
        </div>
    </div>

	<%--<sf:SingleMediaContentItemDialog ID="imageSelector" runat="server" HostedInRadWindow="false" />--%>
    <test:CustomSingleMediaContentItemDialog ID="imageSelector" runat="server" HostedInRadWindow="false" />

    <telerik:RadWindowManager
        id="windowManager"
        runat="server"
        Height="100%"
        Width="100%"
        Behaviors="None"
        Skin="Default"
        InitialBehaviors="Maximize"
        ShowContentDuringLoad="false"
        VisibleStatusBar="false">
        <Windows>
            <telerik:RadWindow ID="imageEditor" runat="server" Height="100" Width="100" ReloadOnShow="true" OnClientShow="OnClientShow" OnClientClose="OnClientClose" />
            <telerik:RadWindow ID="cropResizeRotateDialog" runat="server" Height="100" Width="100" Modal="true" NavigateUrl="~/Sitefinity/Dialog/ImageEditorDialog" ReloadOnShow="true" Behaviors="None" />
        </Windows>
    </telerik:RadWindowManager>
</div>
<sitefinity:ClientLabelManager id="clientLabelManager" runat="server">
    <labels>
		<sitefinity:ClientLabel ClassId="LibrariesResources" Key="Kb" runat="server" />
		<sitefinity:ClientLabel ClassId="LibrariesResources" Key="Mb" runat="server" />
	</labels>
</sitefinity:ClientLabelManager>

<script type="text/javascript">
    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }
    function OnClientShow(oWnd, eventArgs) {
        var containerWnd = GetRadWindow();
        //Maximize the container window
        containerWnd.maximize();

        //Maximize the designer's property editor dialog
        var propertyEditor = dialogBase.get_radWindow().get_contentFrame().contentWindow.top.$find("PropertyEditorDialog");
        if (propertyEditor) {
            var propertyEditorRadWindow = propertyEditor.AjaxDialog.get_radWindow();
            propertyEditorRadWindow.maximize();

            //Prevent locking of the screen, if a previous dialog has been closed with error
            propertyEditorRadWindow.set_modal(false);
        }

        //Remove the class to display properly the dialog and save the elements as global variables
        selectorDialogs = $(".sfSelectorDialog").removeClass("sfSelectorDialog");
        window.parent.selectorDialogs = window.parent.jQuery(".sfSelectorDialog").removeClass("sfSelectorDialog");
    }
    function OnClientClose(oWnd, eventArgs) {
        //Restore the container window
        var containerWnd = GetRadWindow();
        containerWnd.restore();

        //Restore the designer's property editor dialog
        var propertyEditor = dialogBase.get_radWindow().get_contentFrame().contentWindow.top.$find("PropertyEditorDialog");
        if (propertyEditor) {
            var propertyEditorRadWindow = propertyEditor.AjaxDialog.get_radWindow();
            propertyEditorRadWindow.restore();
            propertyEditorRadWindow.set_modal(true);
        }

        //Return the class to the previously saved elements
        selectorDialogs.addClass("sfSelectorDialog");
        window.parent.selectorDialogs.addClass("sfSelectorDialog")
    }
</script>

