using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Sitefinity.Configuration;
using Telerik.Sitefinity.Localization;
using Telerik.Sitefinity.Modules.Libraries;
using Telerik.Sitefinity.Modules.Libraries.Configuration;
using Telerik.Sitefinity.Modules.Libraries.Documents;
using Telerik.Sitefinity.Modules.Libraries.Images;
using Telerik.Sitefinity.Modules.Libraries.Videos;
using Telerik.Sitefinity.Modules.Libraries.Web.UI.Designers;
using Telerik.Sitefinity.Security;
using Telerik.Sitefinity.Security.Claims;
using Telerik.Sitefinity.Services;
using Telerik.Sitefinity.Web.UI;

namespace SitefinityWebApp
{
    public class CustomMediaContentManagerDialog : MediaContentManagerDialog
    {

       protected override void InitializeControls(GenericContainer container)
        {
            base.InitializeControls(container);
            this.ContentSelectorView.LayoutTemplatePath = "~/CustomSingleMediaContentItemView.ascx";

          
           
           
            
           
        }

        public override IEnumerable<ScriptDescriptor> GetScriptDescriptors()
        {
            var descriptor = (ScriptControlDescriptor)base.GetScriptDescriptors().Last();
            descriptor.Type = "Telerik.Sitefinity.Web.UI.MediaContentManagerDialog";
            descriptor.AddComponentProperty("contentSelectorView", this.ContentSelectorView.ClientID);
            descriptor.AddComponentProperty("itemSettingsView", this.ItemSettingsView.ClientID);
            descriptor.AddElementProperty("saveLink", this.SaveLink.ClientID);
            descriptor.AddElementProperty("cancelLink", this.CancelLink.ClientID);
            descriptor.AddElementProperty("buttonArea", this.ButtonArea.ClientID);
            descriptor.AddProperty("dialogMode", this.DialogMode);
            descriptor.AddProperty("videoTag", Config.Get<LibrariesConfig>().ContentBlockVideoTag.ToString());
            descriptor.AddComponentProperty("titleTextField", this.TitleTextField.ClientID);
            descriptor.AddComponentProperty("altTextField", this.AltTextField.ClientID);

            var thumbnailsServiceUrl = string.Format("~/{0}", LibrariesModule.ThumbnailsServiceUrl);
            descriptor.AddProperty("thumbnailServiceUrl", VirtualPathUtility.ToAbsolute(thumbnailsServiceUrl));
            descriptor.AddProperty("thumbnailExtensionPrefix", this.ThumbnailExtensionPrefix);

            return new[] { descriptor };
        }


        private readonly string layoutTemplatePath = "~/CustomMediaContentManagerDialog.ascx";
    
        
    }
}