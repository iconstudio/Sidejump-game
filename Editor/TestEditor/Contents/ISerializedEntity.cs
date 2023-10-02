namespace TestEditor.Contents
{
	internal interface ISerializedEntity
	{
	}

	internal interface ISerializedEntity<in T> : ISerializedEntity
	{
	}
}
