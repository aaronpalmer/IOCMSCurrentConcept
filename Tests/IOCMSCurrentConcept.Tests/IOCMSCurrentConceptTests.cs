using System;
using System.Data.Objects;
using System.Linq;
using System.Transactions;
using IOCMSCurrentConcept.Data;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IOCMSCurrentConcept.Tests
{
    [TestClass]
    public class IOCMSCurrentConceptTests
    {

        // Prove transaction scope is not managed via SaveChanges when stored procedures are involved.
        [TestMethod]
        public void NoTransactionScope_NoEntityUsing_SomethingBlowsUpBeforeSaveChanges_StillSavedFirstData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            var entities = new IOCMSCurrentConceptEntities();

            // insert some data
            entities.uspInitialClassifications_Insert(name, description, newId1);

            var nothingBlowsUp = false;

            if (nothingBlowsUp)
            {
                // insert some data based on results of previous proc call
                entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

                entities.SaveChanges();
            }

            var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
            Assert.AreEqual(name, actualInitial.Name);
            Assert.AreEqual(description, actualInitial.Description);
        }

        [TestMethod]
        public void NoTransactionScope_NoEntityUsing_NoSaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            var entities = new IOCMSCurrentConceptEntities();

            // insert some data
            entities.uspInitialClassifications_Insert(name, description, newId1);

            // insert some data based on results of previous proc call
            entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

            var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
            Assert.AreEqual(name, actualInitial.Name);
            Assert.AreEqual(description, actualInitial.Description);

            var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
            Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
            Assert.AreEqual(description, actualTemp.Description);
        }

        [TestMethod]
        public void NoTransactionScope_NoSaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var entities = new IOCMSCurrentConceptEntities())
            {
                // insert some data
                entities.uspInitialClassifications_Insert(name, description, newId1);

                // insert some data based on results of previous proc call
                entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);
            }

            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        [TestMethod]
        public void NoTransactionScope_SaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var entities = new IOCMSCurrentConceptEntities())
            {
                // insert some data
                entities.uspInitialClassifications_Insert(name, description, newId1);

                // insert some data based on results of previous proc call
                entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

                entities.SaveChanges();
            }

            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        [TestMethod]
        public void TransactionScope_NoComplete_NoSaveChanges_DidNotSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                using (var entities = new IOCMSCurrentConceptEntities())
                {
                    // insert some data
                    entities.uspInitialClassifications_Insert(name, description, newId1);

                    // insert some data based on results of previous proc call
                    entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);
                }
            }


            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).FirstOrDefault();
                Assert.IsNull(actualInitial);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).FirstOrDefault();
                Assert.IsNull(actualTemp);

            }
        }

        [TestMethod]
        public void TransactionScope_NoComplete_SaveChanges_DidNotSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                using (var entities = new IOCMSCurrentConceptEntities())
                {
                    // insert some data
                    entities.uspInitialClassifications_Insert(name, description, newId1);

                    // insert some data based on results of previous proc call
                    entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

                    entities.SaveChanges();
                }
            }


            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).FirstOrDefault();
                Assert.IsNull(actualInitial);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).FirstOrDefault();
                Assert.IsNull(actualTemp);
            }
        }

        [TestMethod]
        public void TransactionScope_Complete_NoSaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                using (var entities = new IOCMSCurrentConceptEntities())
                {
                    // insert some data
                    entities.uspInitialClassifications_Insert(name, description, newId1);

                    // insert some data based on results of previous proc call
                    entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);
                }
                transaction.Complete();
            }


            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        [TestMethod]
        public void TransactionScope_Complete_SaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                using (var entities = new IOCMSCurrentConceptEntities())
                {
                    // insert some data
                    entities.uspInitialClassifications_Insert(name, description, newId1);

                    // insert some data based on results of previous proc call
                    entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

                    entities.SaveChanges();
                }
                transaction.Complete();
            }


            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        [TestMethod]
        public void TransactionScope_NoEntityUsing_Complete_NoSaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                var entities = new IOCMSCurrentConceptEntities();
                // insert some data
                entities.uspInitialClassifications_Insert(name, description, newId1);

                // insert some data based on results of previous proc call
                entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);
                transaction.Complete();
            }

            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        [TestMethod]
        public void TransactionScope_NoEntityUsing_Complete_SaveChanges_DidSaveData()
        {
            const string name = "New Name";
            const string description = "New Description";

            var newId1 = new ObjectParameter("newId", typeof(int));
            var newId2 = new ObjectParameter("newId", typeof(int));

            using (var transaction = new TransactionScope())
            {
                var entities = new IOCMSCurrentConceptEntities();
                // insert some data
                entities.uspInitialClassifications_Insert(name, description, newId1);

                // insert some data based on results of previous proc call
                entities.uspTempClassifications_Insert(String.Format("{0}-{1}", name, newId1.Value), description, newId2);

                entities.SaveChanges();

                transaction.Complete();
            }


            using (var entities = new IOCMSCurrentConceptEntities())
            {
                var actualInitial = entities.uspInitialClassifications_Get((int)newId1.Value).First();
                Assert.AreEqual(name, actualInitial.Name);
                Assert.AreEqual(description, actualInitial.Description);

                var actualTemp = entities.uspTempClassifications_Get((int)newId2.Value).First();
                Assert.AreEqual(String.Format("{0}-{1}", name, newId1.Value), actualTemp.Name);
                Assert.AreEqual(description, actualTemp.Description);
            }
        }

        // Conclusions
        // A non-transactional way of executing stored procedures is not safe.
        // SaveChanges() is irrelevant when dealing with staight stored procedures.
        // Putting the entities into a using statement isn't necessary, but it's a good practice because it's an IDisposable.
    }
}
