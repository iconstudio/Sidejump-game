namespace TestEditor.Contents
{
	internal interface IMapSerial : IMapObject
	{
	}
	internal interface IMapSerial<in T> : IMapObject, IMapSerial
	{
	}
}
