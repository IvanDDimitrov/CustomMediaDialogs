using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Telerik.Sitefinity.Configuration;
using Telerik.Sitefinity.Data;
using Telerik.Sitefinity.Localization;
using Telerik.Sitefinity.Modules.Blogs;
using Telerik.Sitefinity.Modules.Libraries;
using Telerik.Sitefinity.Modules.Libraries.Web.UI.Designers;
using Telerik.Sitefinity.Security;
using Telerik.Sitefinity.Security.Configuration;
using Telerik.Sitefinity.Security.Model;
using Telerik.Sitefinity.Services;
using Telerik.Sitefinity.Web.UI;

namespace SitefinityWebApp
{
    public class CustomSingleMediaContentItemDialog : SingleMediaContentItemDialog
    {
        protected override void InitializeControls(GenericContainer container)
        {
            base.InitializeControls(container);
           

            UserManager manager = UserManager.GetManager();
            RoleManager roleManager = RoleManager.GetManager(SecurityManager.ApplicationRolesProviderName);
            LibrariesManager libMan = LibrariesManager.GetManager();
            BlogsManager blogsManager = BlogsManager.GetManager();
            var theUser = manager.GetUser(SecurityManager.GetCurrentUserId());
            var theRoles = roleManager.GetRolesForUser(theUser.Id);
            if (this.DialogMode == EditorExternalDialogModes.Document)
            {
                var theUserLibrary = libMan.GetDocumentLibraries().Where(l => l.Status == Telerik.Sitefinity.GenericContent.Model.ContentLifecycleStatus.Master);
                foreach (var role in theRoles)
                {
                    if (role.Name == "Editors")
                    {
                        var specifiedRole = roleManager.GetRole("Editors");
                        var principalId = specifiedRole.Id;
                        var objectId = (libMan.GetDocumentLibraries().Where(l => l.Title == "Default Library").First() as ISecuredObject).Id;


                        foreach (var item in theUserLibrary)
                        {
                            
                            Telerik.Sitefinity.Security.Model.Permission permission = libMan.GetPermission(SecurityConstants.Sets.DocumentLibrary.SetName, objectId, principalId);
                            var editorPermissions =  item.GetActivePermissionActionsForCurrentUser();
                            if (permission != null && permission.SetName == "DocumentLibrary" && editorPermissions.Contains("DocumentLibrary.ViewDocumentLibrary"))
                            {
                                base.UploaderView.TargetLibraryId = item.Id;
                            }

                        }
                    }
                }
            }
         
        }

        public override IEnumerable<ScriptDescriptor> GetScriptDescriptors()
        {
            base.GetScriptDescriptors();
            var descriptor = (ScriptControlDescriptor)base.GetScriptDescriptors().Last();

            descriptor.AddComponentProperty("uploaderView", this.UploaderView.ClientID);
            descriptor.AddElementProperty("uploaderSection", this.UploaderSection.ClientID);

            if (SystemManager.CurrentContext.AppSettings.Multilingual)
            {
                descriptor.AddProperty("uiCulture", this.UICulture);
            }

            descriptor.AddComponentProperty("selectorView", this.SelectorView.ClientID);

            descriptor.AddElementProperty("saveLink", this.SaveLink.ClientID);
            descriptor.AddElementProperty("cancelLink", this.CancelLink.ClientID);
            descriptor.AddElementProperty("backLink", this.BackLink.ClientID);
            descriptor.AddElementProperty("titleLabel", ((Control)this.TitleLabel).ClientID);
            descriptor.AddElementProperty("cancelLinkTitle", ((Control)this.CancelLinkTitle).ClientID);
            descriptor.AddElementProperty("backLinkTitle", ((Control)this.BackLinkTitle).ClientID);
            descriptor.AddElementProperty("buttonArea", this.ButtonArea.ClientID);
            descriptor.AddElementProperty("selectorSection", this.SelectorSection.ClientID);
            descriptor.AddElementProperty("filterSection", this.FilterSection.ClientID);
            descriptor.AddComponentProperty("clientLabelManager", this.ClientLabelManager.ClientID);

            descriptor.AddProperty("_bodyCssClass", this.BodyCssClass);
            descriptor.AddProperty("dialogMode", this.DialogMode);
            descriptor.AddProperty("mediaDialogOpenMode", this.MediaDialogOpenMode);
            descriptor.AddProperty("_useOnlyUploadMode", this.UseOnlyUploadMode);
            descriptor.AddProperty("_useOnlySelectMode", this.UseOnlySelectMode);
            descriptor.AddProperty("_sourceLibraryId", this.SourceLibraryId);
         
            descriptor.Type = "Telerik.Sitefinity.Web.UI.SingleMediaContentItemDialog";

            return new[] { descriptor };
        }
       
        
    }
}