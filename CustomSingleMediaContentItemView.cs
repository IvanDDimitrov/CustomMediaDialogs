using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Sitefinity.Modules.Libraries.Web.UI.Designers;
using Telerik.Sitefinity.Web.UI;

namespace SitefinityWebApp
{
    public class CustomSingleMediaContentItemView : SingleMediaContentItemView
    {
        protected virtual  SingleMediaContentItemDialog ImageSelector
        {
            get { return this.Container.GetControl<CustomSingleMediaContentItemDialog>("imageSelector", true); }
        }
    }
}