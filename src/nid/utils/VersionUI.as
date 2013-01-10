package nid.utils 
{
	/**
	 * ...
	 * @author Nidin Vinayakan
	 */
	public class VersionUI 
	{
		
		public function VersionUI() 
		{
			
		}
		
		static public function get versionString():String
		{
			return Version.Major +'.' + Version.Minor + '.' + Version.Build + '-rv' + Version.Revision;
		}
		
	}

}