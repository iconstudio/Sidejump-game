namespace TestEditor.Contents
{
	internal interface IMapEntity : IMapObject
	{
	}
	internal interface IMapEntity<out S> : IMapObject, IMapEntity
		where S : notnull, IMapSerial
	{
		S Serialize();
	}
}
