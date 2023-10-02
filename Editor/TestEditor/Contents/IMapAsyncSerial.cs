using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestEditor.Contents
{
	internal interface IMapAsyncSerial<T> : IMapObject, IMapSerial
	{
		Task<T> Deserialize();
	}
}
